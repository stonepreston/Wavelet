import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Position;

class waveletApp extends Application.AppBase {

    private var waveletModel as WaveletModel;
    private var waveletController as WaveletController;

    function initialize() {
        AppBase.initialize();
        self.waveletModel = new WaveletModel(0);
        self.waveletController = new WaveletController(self.waveletModel);
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        Position.enableLocationEvents(Position.LOCATION_CONTINUOUS, method(:onPosition));
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
        Position.enableLocationEvents(Position.LOCATION_DISABLE, method(:onPosition));
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [ new WaveletView(self.waveletModel), new WaveletDelegate(self.waveletController) ];
    }

    public function onPosition(info as Info) as Void {
        self.waveletModel.setGPSQuality(info.accuracy);
    }

}

function getApp() as waveletApp {
    return Application.getApp() as waveletApp;
}