import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.System;
import Toybox.Activity;

class DiscardConfirmationController
{
    private var waveletModel as WaveletModel;
    private var progressBar as WatchUi.ProgressBar;

    public function initialize(waveletModel as WaveletModel) {
      self.waveletModel = waveletModel;
      self.progressBar = new WatchUi.ProgressBar(
            "Discarding",
            null
        );
    }

    public function confirmSelected() as Void {
        System.println("Confirm discard selected");

        var discardProgressController = new DiscardProgressController(self.waveletModel, self.progressBar);

        // https://forums.garmin.com/developer/connect-iq/f/discussion/361156/why-i-am-not-able-to-pushview-in-the-confirmation-delegate
        // See above for reason I am calling switchToView as well as pushView back to back
        WatchUi.switchToView(progressBar, new DiscardProgressDelegate(discardProgressController), WatchUi.SLIDE_LEFT);
        WatchUi.pushView(progressBar, new DiscardProgressDelegate(discardProgressController), WatchUi.SLIDE_LEFT);
    }

    public function cancelSelected() as Void {
        System.println("Cancel selected");
    }
    

}
