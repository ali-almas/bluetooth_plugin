import Flutter
import UIKit
import CoreBluetooth

enum BluetoothPluginError: Error {
    case error
}

public class SwiftBluetoothPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "bluetooth_plugin", binaryMessenger: registrar.messenger())
        let instance = SwiftBluetoothPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    private var centralManager: CBCentralManager?
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method.cased {
        case .scan:
            scan(arguments: call.arguments)
        default:
            result("No method found")
        }
    }
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
    
    
    public func scan(arguments: Any?) {
        if let args = arguments as? [UUID] {
            let services: [CBUUID]? = args.map({CBUUID(nsuuid: $0)})
            
            if centralManager?.state == .poweredOn {
                centralManager?.scanForPeripherals(withServices: services, options: nil)
            }
        }
    }
}

extension SwiftBluetoothPlugin: CBCentralManagerDelegate {
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print(#function, central.state.rawValue)
    }
    
    public func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print(#function, error as Any)
        print(#function, peripheral)
    }
    
    public func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print(#function, error as Any, peripheral)
    }
    
    public func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print(#function, peripheral)
    }
    
    public func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
        print(#function, dict)
    }
    
    public func centralManager(_ central: CBCentralManager, didUpdateANCSAuthorizationFor peripheral: CBPeripheral) {
        print(#function, peripheral)
    }
    
    public func centralManager(_ central: CBCentralManager, connectionEventDidOccur event: CBConnectionEvent, for peripheral: CBPeripheral) {
        print(#function, event, peripheral)
    }
    
    public func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print(#function, peripheral.name, RSSI)
    }
}
