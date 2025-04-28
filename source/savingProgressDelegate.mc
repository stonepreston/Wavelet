import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Timer;
import Toybox.Position;
import Toybox.Attention;

class SavingProgressDelegate extends WatchUi.BehaviorDelegate {

    private var savingProgressController as SavingProgressController;

    function initialize(savingProgressController as SavingProgressController) {
        BehaviorDelegate.initialize();
        self.savingProgressController = savingProgressController;
    }

    function onBack() as Lang.Boolean {
        self.savingProgressController.backPressed();
        return true;
    }

}