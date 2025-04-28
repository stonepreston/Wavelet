import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Timer;

class SavingProgressController
{
    private var waveletModel as WaveletModel;
    private var initialTimer as Timer.Timer?;
    private var finalTimer as Timer.Timer?;
    private var progressBar as WatchUi.ProgressBar;
    private var exitApp as Boolean;
    private var saved as Boolean = false;

    public function initialize(waveletModel as WaveletModel, progressBar as WatchUi.ProgressBar, exitApp as Boolean) {
        self.waveletModel = waveletModel;
        self.progressBar = progressBar;
        self.initialTimer = new Timer.Timer();
        self.finalTimer = new Timer.Timer();
        self.exitApp = exitApp;
        initialTimer.start(method(:initialTimerCallback), 2000, true);
    }

    public function initialTimerCallback() as Void {
        // waits for a second to make it look like its doing stuff before saving
        saved = self.waveletModel.save();
        if (saved) {
            progressBar.setDisplayString("Saved!");
        } else {
            progressBar.setDisplayString("Failed!");
        }
        // start the other timer so that we display the new status for a bit before dismissing the view
        initialTimer.stop();
        self.finalTimer.start(method(:finalTimerCallback), 3000, true);
    }

    public function finalTimerCallback() as Void {
        self.stopAndNullTimers();
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
        if (self.exitApp) {
            System.exit();
        }
    }

    public function backPressed() as Void {
        System.println("Back pressed in Saving Progress Bar");
        self.stopAndNullTimers();
        // Note: top view is automatically popped when back is pressed
    }

    private function stopAndNullTimers() as Void {
        self.initialTimer.stop();
        self.finalTimer.stop();
        self.initialTimer = null;
        self.finalTimer = null;
    }
    

}