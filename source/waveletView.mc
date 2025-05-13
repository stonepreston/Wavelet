import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.System;

class WaveletView extends WatchUi.View {

    private var waveletModel as WaveletModel;
    private var numberOfWavesLabel;
    private var currentTimeLabel;
    private var sessionHoursMinutesLabel;
    private var sessionSecondsLabel;
    private var caloriesLabel;
    private var bpmLabel;
    private var playIcon;
    private var heartIcon;
    private var gpsProgressBar as WatchUi.ProgressBar;

    function initialize(waveletModel as WaveletModel) {
        View.initialize();
        self.waveletModel = waveletModel;
        self.gpsProgressBar = new WatchUi.ProgressBar("\nObtaining \nGPS \nSignal", null);
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
        numberOfWavesLabel = findDrawableById("num_waves");
        currentTimeLabel = findDrawableById("current_time");
        sessionHoursMinutesLabel = findDrawableById("session_hours_minutes");
        sessionSecondsLabel = findDrawableById("session_seconds");
        caloriesLabel = findDrawableById("calories");
        bpmLabel = findDrawableById("bpm");
        playIcon = findDrawableById("play");
        heartIcon = findDrawableById("heart");
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {

        if (!self.waveletModel.getIsGPSObtained() and !self.waveletModel.getIsGPSSkipped()) {
            
            System.println("Showing progress bar for GPS");
            var gpsProgressController = new GPSProgressController(self.waveletModel);
            WatchUi.pushView(
                gpsProgressBar,
                new GPSProgressDelegate(gpsProgressController),
                WatchUi.SLIDE_IMMEDIATE
            );
        }
        
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        updateNumWavesLabel();
        updateCurrentTimeLabel();
        updateSessionTimeLabels();
        updateSessionCalorieLabel();
        updateSessionBPMLabel();
        updatePlayStatus();

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    function updateNumWavesLabel() {
        numberOfWavesLabel.setText(self.waveletModel.getNumberOfWaves().toString());
    }

    function updateCurrentTimeLabel() {
        var is24Hour = System.getDeviceSettings().is24Hour;
        var time = self.waveletModel.getCurrentTime();
        var hour = is24Hour ? time.hour : 1 + (time.hour + 11) % 12;
        currentTimeLabel.setText(hour.format("%d") + ":" + self.waveletModel.getCurrentTime().min.format("%02d"));
    }

    function updateSessionTimeLabels() {
        var activityTime = self.waveletModel.getActivityTimerTime();
        var hoursMinutes = "0:00";
        var seconds = "00";
        if (activityTime != null) {
            hoursMinutes = toHM(activityTime/1000);
            seconds = toS(activityTime/1000);
        }
        sessionHoursMinutesLabel.setText(hoursMinutes);
        sessionSecondsLabel.setText(seconds);
    }

    function updateSessionCalorieLabel() {
        var activityCalories = self.waveletModel.getActivityCalories();
        
        var calories = "0";
        if (activityCalories != null) {
            System.println("activity calories: " + activityCalories.format("%d"));
            calories = activityCalories.format("%d");
        }
        caloriesLabel.setText(calories);
    }

    function updateSessionBPMLabel() {
        var activityBPM = self.waveletModel.getActivityHeartrate();
        
        var BPM = "--";
        if (activityBPM != null) {
            System.println("activity BPM: " + activityBPM.format("%d"));
            BPM = activityBPM.format("%d");
        }
        bpmLabel.setText(BPM);
    }

    function toHM(secs as Lang.Number) as Lang.String {
        var hr = secs/3600;
        var min = (secs-(hr*3600))/60;
        return hr.format("%d")+":"+min.format("%02d");
    } 

    function toS(secs as Lang.Number) as Lang.String {
        var sec = secs%60;
        return sec.format("%02d");
    } 

    function updatePlayStatus() {
        if (self.waveletModel.isRecording()) {
            playIcon.setVisible(false);
            heartIcon.setVisible(true);
            bpmLabel.setVisible(true);
        } else {

            playIcon.setVisible(true);
            heartIcon.setVisible(false);
            bpmLabel.setVisible(false);
        }
    }

}
