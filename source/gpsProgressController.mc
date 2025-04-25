import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Timer;

class GPSProgressController
{
    private var waveletModel as WaveletModel;
    private var secondTimer as Timer.Timer?;

    public function initialize(waveletModel as WaveletModel) {
        self.waveletModel = waveletModel;
        self.secondTimer = new Timer.Timer();
        secondTimer.start(method(:secondTimerCallback), 1000, true);
    }

    public function secondTimerCallback() as Void {
        if (self.waveletModel.getGPSQuality() == Position.QUALITY_GOOD or self.waveletModel.getGPSQuality() == Position.QUALITY_USABLE) {
            secondTimer.stop();
            System.println("Sufficient GPS quality obtained! Showing main view");
            Attention.vibrate(self.waveletModel.getVibeData());
            self.waveletModel.setIsGPSObtained(true);
            WatchUi.popView(WatchUi.SLIDE_LEFT);
        }
    }

    public function backPressed() as Void {
        System.println("Back pressed in GPS Progress Bar");
        self.waveletModel.setIsGPSSkipped(true);
        // Note: view is automatically popped when back is pressed
        // WatchUi.popView(WatchUi.SLIDE_LEFT);
    }
    

}