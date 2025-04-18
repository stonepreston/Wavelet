import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;

class waveletDelegate extends WatchUi.BehaviorDelegate {

    private var waveletController as WaveletController;

    function initialize(waveletController as WaveletController) {
        BehaviorDelegate.initialize();
        self.waveletController = waveletController;
    }

    public function onKey(evt as KeyEvent) as Boolean {
        var key = evt.getKey();
        System.println(key);
        if (key == KEY_UP) {
            self.waveletController.upPressed();
        } else if (key == KEY_DOWN) {
            self.waveletController.downPressed();
        } else if (key == KEY_ENTER) {
            self.waveletController.enterPressed();
        }

        return true;
    }

}