import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.System;
import Toybox.Activity;

class QuitConfirmationController
{
    private var waveletModel as WaveletModel;
    private var progressBar as WatchUi.ProgressBar;

    public function initialize(waveletModel as WaveletModel) {
      self.waveletModel = waveletModel;
      self.progressBar = new WatchUi.ProgressBar(
            "Saving",
            null
        );
    }

    public function yesSelected() as Void {
        System.println("Save activity before quit selected");

        System.println("Showing progress bar for save");
        var savingProgressController = new SavingProgressController(self.waveletModel, self.progressBar, true);
        // https://forums.garmin.com/developer/connect-iq/f/discussion/361156/why-i-am-not-able-to-pushview-in-the-confirmation-delegate
        // See above for reason I am calling switchToView as well as pushView back to back
        WatchUi.switchToView(progressBar, new SavingProgressDelegate(savingProgressController), WatchUi.SLIDE_LEFT);
        WatchUi.pushView(progressBar, new SavingProgressDelegate(savingProgressController), WatchUi.SLIDE_LEFT);
    }

    public function noSelected() as Void {
        System.println("Save activity before quit not selected");
        self.waveletModel.discard();
        System.exit();
    }
    

}
