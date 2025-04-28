import Toybox.Lang;
import Toybox.System;
import Toybox.ActivityRecording;
import Toybox.Attention;
import Toybox.Position;
import Toybox.FitContributor;

typedef VibeContainer as Array<Attention.VibeProfile>;

class WaveletModel
{
    private var numberOfWaves as Integer = 0;
    private var currentTime as System.ClockTime;
    private var session as Session?;
    private var isGPSObtained = false;
    private var isGPSSkipped = false;
    private var gpsQuality = Position.QUALITY_NOT_AVAILABLE;
    private var vibeData as VibeContainer;
    private var totalWavesField as FitContributor.Field?;
    private var hasSessionBeenStartedFirstTime = false;

    public function initialize(numberOfWaves as Integer) {
      self.numberOfWaves = numberOfWaves;
      self.currentTime = System.getClockTime();
      self.vibeData = [new Attention.VibeProfile(50, 500)];
    }

    public function getNumberOfWaves() as Integer {
        return self.numberOfWaves;
    }

    public function incrementNumberOfWaves() as Void {
        if (self.isRecording()) {
            self.numberOfWaves = self.numberOfWaves + 1;
            if (self.totalWavesField != null) {
                self.totalWavesField.setData(self.numberOfWaves);
            }
            self.session.addLap();
        }
    }

    // not currently used since laps are used and laps cant be manually decreased
    public function decrementNumberOfWaves() as Void {
        if (self.isRecording()) {
            if (self.numberOfWaves >= 1) {
                self.numberOfWaves = self.numberOfWaves - 1;
            }
        }
    }

    public function getCurrentTime() as System.ClockTime {
        return self.currentTime;
    }

    public function setCurrentTime(currentTime as System.ClockTime) as Void {
        self.currentTime = currentTime;
    }

    public function getSession() as Session? {
        return session;
    }

    public function resetSession() as Void {
        System.println("Resetting session");
        self.numberOfWaves = 0;
        self.hasSessionBeenStartedFirstTime = false;
        self.session = null;
        // creating the session seems to take a while so do it here to preload it while a save or discard is spinning
        self.createSession();
    }

    public function startOrPauseRecording() as Void {
        if (self.session == null) {
            self.createSession();
            System.println("Starting Recording");
            self.session.start();
            self.hasSessionBeenStartedFirstTime = true;
            Attention.playTone(Attention.TONE_START);
        } else {
            // Session already exists so we need to either start or pause
            if (self.session.isRecording()) {
                System.println("Stopping recording");
                self.session.stop();
                Attention.playTone(Attention.TONE_STOP);
            } else {
                System.println("Starting recording");
                self.session.start();
                self.hasSessionBeenStartedFirstTime = true;
                Attention.playTone(Attention.TONE_START);
            }
        }
        Attention.vibrate(self.vibeData);
        
    }

    public function getActivityTimerTime() as Lang.Number? {
        if (self.session != null) {
            var info = Activity.getActivityInfo();
            if (info != null) {
                return info.timerTime;
            }
        }

        return null;
    }

    public function getActivityCalories() as Lang.Number? {
        if (self.session != null) {
            var info = Activity.getActivityInfo();
            if (info != null) {
                return info.calories;
            }
        }
        System.println("Returning null calories");
        return null;
    }

    public function getActivityHeartrate() as Lang.Number? {
        if (self.session != null) {
            var info = Activity.getActivityInfo();
            if (info != null) {
                return info.currentHeartRate;
            }
        }
        System.println("Returning null heartrate");
        return null;
    }

    public function isRecording() as Lang.Boolean {
        if (self.session != null) {
            return self.session.isRecording();
        } else {
            return false;
        }
    }

    public function save() as Boolean {
        System.println("Saving session ... ");
        self.session.stop();
        var saveStatus = self.session.save();
        if (saveStatus ==  true) {
            self.resetSession();
            System.println("Save was successful!");
        } else {
            System.println("Save was NOT successful!");
        }
        
        return saveStatus;
    }

    public function discard() as Boolean {
        System.println("Discarding session ... ");
        self.session.stop();
        var discardStatus = self.session.discard();
        if (discardStatus ==  true) {
            self.resetSession();
            System.println("Discard was successful!");
        } else {
            System.println("Discard was NOT successful!");
        }
        
        return discardStatus;
    }

    public function getIsGPSObtained() as Boolean {
        return self.isGPSObtained;
    }

    public function setIsGPSObtained(value as Boolean) as Void {
        self.isGPSObtained = value;
    }

    public function getIsGPSSkipped() as Boolean {
        return self.isGPSSkipped;
    }

    public function setIsGPSSkipped(value as Boolean) as Void {
        self.isGPSSkipped = value;
    }

    public function getGPSQuality() as Position.Quality {
        return self.gpsQuality;
    }

    public function setGPSQuality(value as Position.Quality) as Void {
        self.gpsQuality = value;
    }

    public function getVibeData() as VibeContainer {
        return self.vibeData;
    }

    private function createSession() as Void {
        self.session = ActivityRecording.createSession({:name=>"Surfing", :sport=>Activity.SPORT_SURFING});
        self.totalWavesField = self.session.createField("TotalWaves", 2, FitContributor.DATA_TYPE_UINT32, {:mesgType => FitContributor.MESG_TYPE_SESSION});
    }

    public function getHasSessionBeenStartedFirstTime() as Boolean {
        return self.hasSessionBeenStartedFirstTime;
    }

}
