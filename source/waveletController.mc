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
        System.println("Enter pressed in main view");
        self.waveletModel.startOrPauseRecording();
        if (!self.waveletModel.isRecording()) {
            // If we are not recording then that means its been paused and we need to show the menu
            var waveletMenuController = new WaveletMenuController(self.waveletModel);
            WatchUi.pushView(new Rez.Menus.MainMenu(), new WaveletMenuDelegate(waveletMenuController), WatchUi.SLIDE_LEFT);

        }
        WatchUi.requestUpdate();
    }

    public function backPressed() as Void {
        if (self.waveletModel.getHasSessionBeenStartedFirstTime()) {
            var message = "Save activity?";
            var dialog = new WatchUi.Confirmation(message);
            var quitConfirmationController = new QuitConfirmationController(self.waveletModel);
            WatchUi.pushView(
                dialog,
                new QuitConfirmationDelegate(quitConfirmationController),
                WatchUi.SLIDE_LEFT
            );
        } else {
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        }
    }
}
