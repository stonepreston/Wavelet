import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.System;
import Toybox.Activity;

class WaveletMenuController
{
    private var waveletModel as WaveletModel;
    public function initialize(waveletModel as WaveletModel) {
      self.waveletModel = waveletModel;
    }

    public function resumeSelected() as Void {
        System.println("Resume selected");
        self.waveletModel.startOrPauseRecording();
        WatchUi.popView(WatchUi.SLIDE_LEFT);
    }

    public function saveSelected() as Void {
        System.println("Save selected");
        self.waveletModel.save();
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }

    public function discardSelected() as Void {
        System.println("Discard selected");
        var message = "Discard?";
        var dialog = new WatchUi.Confirmation(message);
        var discardConfirmationController = new DiscardConfirmationController(self.waveletModel);
        WatchUi.pushView(
            dialog,
            new DiscardConfirmationDelegate(discardConfirmationController),
            WatchUi.SLIDE_RIGHT
        );
    }

    public function backPressed() as Void {
        System.println("Back pressed");
        WatchUi.popView(WatchUi.SLIDE_LEFT);
    }
    

}
