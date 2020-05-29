import UIKit
import Flutter
import Firebase
import firebase_messaging

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
    GeneratedPluginRegistrant.register(with: self)

    FLTFirebaseMessagingPlugin.setPluginRegistrantCallback({ (registry: FlutterPluginRegistry) -> Void in
          GeneratedPluginRegistrant.register(with: registry);
        });

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
