import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.System;
import Toybox.Activity;

class WaveletController
{
    private var waveletModel as WaveletModel;
    private var secondTimer as Timer.Timer?;
    public function initialize(waveletModel as WaveletModel) {
      self.waveletModel = waveletModel;
      self.secondTimer = new Timer.Timer();
      secondTimer.start(method(:secondTimerCallback), 1000, true);
    }

    public function upPressed() as Void {
        self.waveletModel.incrementNumberOfWaves();
        WatchUi.requestUpdate();
    }

    public function downPressed() as Void {
        self.waveletModel.decrementNumberOfWaves();
        WatchUi.requestUpdate();
    }

    public function secondTimerCallback() as Void {
        self.waveletModel.setCurrentTime(System.getClockTime());
        WatchUi.requestUpdate();
    }

    public function enterPressed() as Void {
        self.waveletModel.startOrPauseRecording();
        WatchUi.requestUpdate();
    }
}
