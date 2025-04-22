import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.System;
import Toybox.Activity;

class QuitConfirmationController
{
    private var waveletModel as WaveletModel;
    public function initialize(waveletModel as WaveletModel) {
      self.waveletModel = waveletModel;
    }

    public function yesSelected() as Void {
        System.println("Save activity before quit selected");
        self.waveletModel.save();
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }

    public function noSelected() as Void {
        System.println("Save activity before quit not selected");
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
    

}
