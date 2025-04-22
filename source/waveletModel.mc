import Toybox.Lang;
import Toybox.System;
import Toybox.ActivityRecording;
import Toybox.Attention;

class WaveletModel
{
    private var numberOfWaves as Integer = 0;
    private var currentTime as System.ClockTime;
    private var session as Session?;

    public function initialize(numberOfWaves as Integer) {
      self.numberOfWaves = numberOfWaves;
      self.currentTime = System.getClockTime();
    }

    public function getNumberOfWaves() as Integer {
        return self.numberOfWaves;
    }

    public function incrementNumberOfWaves() as Void {
        if (self.isRecording()) {
            self.numberOfWaves = self.numberOfWaves + 1;
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
        System.println("Resetting session to null");
        self.numberOfWaves = 0;
        self.session = null;
    }

    public function startOrPauseRecording() as Void {
        var vibeData = [new Attention.VibeProfile(50, 500)];
        if (self.session == null) {
            self.session = ActivityRecording.createSession({:name=>"Surfing", :sport=>Activity.SPORT_SURFING});
            System.println("Starting Recording");
            self.session.start();
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
                Attention.playTone(Attention.TONE_START);
            }
        }
        Attention.vibrate(vibeData);
        
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

    public function save() as Void {
        System.println("Saving session ... ");
        self.session.save();
        self.resetSession();
        System.println("Save complete!");
    }
}
