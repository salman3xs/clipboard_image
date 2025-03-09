import Flutter
import UIKit

public class ClipboadImagePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "clipboad_image", binaryMessenger: registrar.messenger())
    let instance = ClipboadImagePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getImage":
      self.getClipboardImage(result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func getClipboardImage(result: FlutterResult) {
        if let image = UIPasteboard.general.image,
           let data = image.jpegData(compressionQuality: 0.9) {
            result(data)
        } else {
            result(nil)
        }
    }
}
