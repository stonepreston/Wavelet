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
        WatchUi.popView(WatchUi.SLIDE_DOWN);
    }

    public function saveSelected() as Void {
        System.println("Save selected");
        WatchUi.popView(WatchUi.SLIDE_DOWN);
    }

    public function discardSelected() as Void {
        System.println("Discard selected");
        self.waveletModel.resetSession();
        WatchUi.popView(WatchUi.SLIDE_DOWN);
    }

    public function backPressed() as Void {
        System.println("Back pressed");
        WatchUi.popView(WatchUi.SLIDE_DOWN);
    }
    

}
