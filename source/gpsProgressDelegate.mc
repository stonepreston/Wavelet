import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Timer;
import Toybox.Position;
import Toybox.Attention;

class GPSProgressDelegate extends WatchUi.BehaviorDelegate {

    private var gpsProgressController as GPSProgressController;

    function initialize(gpsProgressController as GPSProgressController) {
        BehaviorDelegate.initialize();
        self.gpsProgressController = gpsProgressController;
    }

    function onBack() as Lang.Boolean {
        self.gpsProgressController.backPressed();
        return true;
    }

}