import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
   let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let deviceInfoChannel = FlutterMethodChannel(
            name: "com.example.ecom/device_info",
            binaryMessenger: controller.binaryMessenger
    )

    deviceInfoChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
                if call.method == "getDeviceInfo" {
                    self.getDeviceInfo(result: result)
                } else {
                    result(FlutterMethodNotImplemented)
                }
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // Swift function to fetch device information
      private func getDeviceInfo(result: @escaping FlutterResult) {
          let device = UIDevice.current

          // Get device model name
          let modelName = getDeviceModelName()

          // Get system information
          let systemName = device.systemName
          let systemVersion = device.systemVersion
          let deviceName = device.name

          // Get app information
          let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
          let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"

          // Create device info dictionary
          let deviceInfo: [String: Any] = [
              "deviceModel": modelName,
              "systemName": systemName,
              "systemVersion": systemVersion,
              "deviceName": deviceName,
              "appVersion": appVersion,
              "buildNumber": buildNumber,
              "isPhysicalDevice": !isSimulator()
          ]

          result(deviceInfo)
      }

      // Helper function to get device model name
      private func getDeviceModelName() -> String {
          var systemInfo = utsname()
          uname(&systemInfo)
          let machineMirror = Mirror(reflecting: systemInfo.machine)
          let identifier = machineMirror.children.reduce("") { identifier, element in
              guard let value = element.value as? Int8, value != 0 else { return identifier }
              let unicodeScalar = UnicodeScalar(UInt8(value))
              return identifier + String(unicodeScalar)
          }

          return mapToDeviceName(identifier: identifier)
      }

      // Map device identifier to readable name
      private func mapToDeviceName(identifier: String) -> String {
          switch identifier {
          case "iPhone12,1": return "iPhone 11"
          case "iPhone12,3": return "iPhone 11 Pro"
          case "iPhone12,5": return "iPhone 11 Pro Max"
          case "iPhone13,1": return "iPhone 12 mini"
          case "iPhone13,2": return "iPhone 12"
          case "iPhone13,3": return "iPhone 12 Pro"
          case "iPhone13,4": return "iPhone 12 Pro Max"
          case "iPhone14,4": return "iPhone 13 mini"
          case "iPhone14,5": return "iPhone 13"
          case "iPhone14,2": return "iPhone 13 Pro"
          case "iPhone14,3": return "iPhone 13 Pro Max"
          case "iPhone14,7": return "iPhone 14"
          case "iPhone14,8": return "iPhone 14 Plus"
          case "iPhone15,2": return "iPhone 14 Pro"
          case "iPhone15,3": return "iPhone 14 Pro Max"
          case "iPhone15,4": return "iPhone 15"
          case "iPhone15,5": return "iPhone 15 Plus"
          case "iPhone16,1": return "iPhone 15 Pro"
          case "iPhone16,2": return "iPhone 15 Pro Max"
          // iPad models
          case "iPad13,1", "iPad13,2": return "iPad Air (4th generation)"
          case "iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7": return "iPad Pro 11-inch (3rd generation)"
          case "iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11": return "iPad Pro 12.9-inch (5th generation)"
          // Simulator
          case "i386", "x86_64": return "Simulator"
          default: return identifier
          }
      }

      // Check if running on simulator
      private func isSimulator() -> Bool {
          #if targetEnvironment(simulator)
          return true
          #else
          return false
          #endif
      }
}
