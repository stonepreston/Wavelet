import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.System;
import Toybox.Activity;

class WaveletMenuController
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

    public function resumeSelected() as Void {
        System.println("Resume selected");
        self.waveletModel.startOrPauseRecording();
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }

    public function saveSelected() as Void {
        System.println("Save selected");
        System.println("Showing progress bar for save");
        var savingProgressController = new SavingProgressController(self.waveletModel, self.progressBar, false);
        WatchUi.switchToView(
            progressBar,
            new SavingProgressDelegate(savingProgressController),
            WatchUi.SLIDE_LEFT
        );
    }

    public function discardSelected() as Void {
        System.println("Discard selected");
        var message = "Discard?";
        var dialog = new WatchUi.Confirmation(message);
        var discardConfirmationController = new DiscardConfirmationController(self.waveletModel);
        WatchUi.switchToView(
            dialog,
            new DiscardConfirmationDelegate(discardConfirmationController),
            WatchUi.SLIDE_LEFT
        );
    }

    public function backPressed() as Void {
        System.println("Back pressed");
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }
    

}
