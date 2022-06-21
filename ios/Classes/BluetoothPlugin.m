#import "BluetoothPlugin.h"
#if __has_include(<bluetooth_plugin/bluetooth_plugin-Swift.h>)
#import <bluetooth_plugin/bluetooth_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "bluetooth_plugin-Swift.h"
#endif

@implementation BluetoothPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBluetoothPlugin registerWithRegistrar:registrar];
}
@end
