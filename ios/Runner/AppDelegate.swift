import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController;
          let crossChannel = FlutterMethodChannel.init(name: "samples.flutter.io/systemVersion",
                                                       binaryMessenger: controller as! FlutterBinaryMessenger);
          crossChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: FlutterResult) -> Void in
              let device = UIDevice.current;
                print("systemVersion：",device.systemVersion);
                result(device.systemVersion);
          });
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
