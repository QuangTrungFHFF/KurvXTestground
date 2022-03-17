//
//  KurvxBLEPeripheralManager.swift
//  KurvX testground
//
//  Created by Trung Tran on 15.03.22.
//

import Foundation
import CoreBluetooth

public class KurvxBLEPeripheralManager: NSObject, CBCentralManagerDelegate{
    
    
    public static let shared = KurvxBLEPeripheralManager()
    
    public private(set) var centralManager : CBCentralManager?
    
    private override init(){
        super.init()
        
        let kurvxManagerOptions = [CBCentralManagerOptionShowPowerAlertKey : NSNumber(value:true)]
        let centralManagerDispatchQueue = DispatchQueue(label: "",qos: .userInteractive, attributes: .concurrent)
        centralManager = CBCentralManager(delegate: self, queue: centralManagerDispatchQueue,options: kurvxManagerOptions)
        
    }
    
    public func discoverDevices() {
        
        let kurvxBaseService = [getBaseServiceUUID()]
        print("discoverDevices : Base UUID \(kurvxBaseService.description)")
        centralManager!.scanForPeripherals(withServices: kurvxBaseService, options: [CBCentralManagerScanOptionAllowDuplicatesKey : NSNumber(value: false)])
    }
    
    public func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print(peripheral)
    }
    
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
          case .unknown:
            print("central.state is .unknown")
          case .resetting:
            print("central.state is .resetting")
          case .unsupported:
            print("central.state is .unsupported")
          case .unauthorized:
            print("central.state is .unauthorized")
          case .poweredOff:
            print("central.state is .poweredOff")
          case .poweredOn:
            print("central.state is .poweredOn")
        @unknown default:
            print("central.state is on newly added state")
        }

    }
}
