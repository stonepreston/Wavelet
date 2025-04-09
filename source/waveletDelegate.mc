import Toybox.Lang;
import Toybox.WatchUi;

class waveletDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new waveletMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}