import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.System;
import Toybox.Activity;

class DiscardConfirmationController
{
    private var waveletModel as WaveletModel;
    public function initialize(waveletModel as WaveletModel) {
      self.waveletModel = waveletModel;
    }

    public function confirmSelected() as Void {
        System.println("Confirm discard selected");
        self.waveletModel.resetSession();
        WatchUi.popView(WatchUi.SLIDE_LEFT);
    }

    public function cancelSelected() as Void {
        System.println("Cancel selected");
        WatchUi.popView(WatchUi.SLIDE_LEFT);
    }
    

}
