import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Timer;
import Toybox.Position;
import Toybox.Attention;

class DiscardProgressDelegate extends WatchUi.BehaviorDelegate {

    private var discardProgressController as DiscardProgressController;

    function initialize(discardProgressController as DiscardProgressController) {
        BehaviorDelegate.initialize();
        self.discardProgressController = discardProgressController;
    }

    function onBack() as Lang.Boolean {
        self.discardProgressController.backPressed();
        return true;
    }

}