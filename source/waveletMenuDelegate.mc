import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class WaveletMenuDelegate extends WatchUi.Menu2InputDelegate {

    private var waveletMenuController as WaveletMenuController;

    function initialize(waveletMenuController as WaveletMenuController) {
        Menu2InputDelegate.initialize();
        self.waveletMenuController = waveletMenuController;
    }

    public function onSelect(item as MenuItem) as Void {
        
        var id = item.getId() as Symbol;
        if (id == :resume) {
            waveletMenuController.resumeSelected();
        } else if (id == :save) {
            waveletMenuController.saveSelected();
        } else if (id == :discard) {
            waveletMenuController.discardSelected();
        }
    }

    public function onBack() as Void {
        waveletMenuController.backPressed();
    }

}