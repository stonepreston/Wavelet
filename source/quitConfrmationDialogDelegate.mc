import Toybox.Lang;
import Toybox.WatchUi;

//! Input handler for the confirmation dialog
class QuitConfirmationDelegate extends WatchUi.ConfirmationDelegate {

    private var quitConfirmationController as QuitConfirmationController;

    function initialize(quitConfirmationController as QuitConfirmationController) {
        ConfirmationDelegate.initialize();
        self.quitConfirmationController = quitConfirmationController;
    }

    function onResponse(response as WatchUi.Confirm) as Lang.Boolean {
        if (response == WatchUi.CONFIRM_NO) {
            quitConfirmationController.noSelected();
        } else {
            quitConfirmationController.yesSelected();
        }

        return true;
    }
}