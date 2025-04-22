import Toybox.Lang;
import Toybox.WatchUi;

//! Input handler for the confirmation dialog
class DiscardConfirmationDelegate extends WatchUi.ConfirmationDelegate {

    private var discardConfirmationController as DiscardConfirmationController;

    function initialize(discardConfirmationController as DiscardConfirmationController) {
        ConfirmationDelegate.initialize();
        self.discardConfirmationController = discardConfirmationController;
    }

    function onResponse(response as WatchUi.Confirm) as Lang.Boolean {
        if (response == WatchUi.CONFIRM_NO) {
            discardConfirmationController.cancelSelected();
        } else {
            discardConfirmationController.confirmSelected();
        }

        return true;
    }
}