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
    
    var kurvxDiscoveringDelegate: KurvxDiscoveringDelegate!
          
    private override init(){
        super.init()
        
        let kurvxManagerOptions = [CBCentralManagerOptionShowPowerAlertKey : NSNumber(value:true)]
        let centralManagerDispatchQueue = DispatchQueue(label: "",qos: .userInteractive, attributes: .concurrent)
        centralManager = CBCentralManager(delegate: self, queue: centralManagerDispatchQueue,options: kurvxManagerOptions)
        
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
    
    //MARK: KurvX scanning
    public func discoverDevices() {
        
        let kurvxBaseService = [getBaseServiceUUID()]
        print("discoverDevices : Base UUID \(kurvxBaseService.description)")
        centralManager!.scanForPeripherals(withServices: kurvxBaseService, options: [CBCentralManagerScanOptionAllowDuplicatesKey : NSNumber(value: false)])
    }
    
    //BLE device discovering delegate
    public func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        var modelNumber : String = NSLocalizedString("n/a", comment: "n/a")
        var serialNumber : String = NSLocalizedString("n/a", comment: "n/a")
        if(onPeripheralChecking(didDiscover: peripheral, advertisementData: advertisementData, modelNumber: &modelNumber)){
            serialNumber = getDeviceSerialNumber(data: advertisementData)
        }
        kurvxDiscoveringDelegate.onKurvxDiscovered(didDiscover: peripheral, withSerial: serialNumber.substring(to: 8), withModel: modelNumber, withRSSI: RSSI.int64Value)
        
        print(peripheral)
    }
    
    
    
    //Check if the device is a supported kurvx device
    private func onPeripheralChecking(didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], modelNumber: inout String) -> Bool{
        if (checkIfAlreadyConnectedBefore()) {
              return false
        }else if let serviceUUIDsData = advertisementData[CBAdvertisementDataServiceDataKey] as? [CBUUID: Data] {
            if let data = serviceUUIDsData[BLEUUIDs.getBLEDeviceInformationServiceUUID()]{
                if let modelStr = String(data: data, encoding: .utf8) {
                    for model in kurvx_device_model_supported{
                        if model == modelStr {
                            modelNumber = modelStr
                            return true
                        }
                    }
                }
            }
        }
        if(peripheral.name == KurvxBLEUtils.KURVX_DFU_NAME || peripheral.name == KurvxBLEUtils.KURVX_DFU_NAME_SHORT){
            return true
        }else if advertisementData[CBAdvertisementDataServiceDataKey] == nil {
            return true
        }
        return false
    }
    
    
    
    //MARK: Helper function
    private func checkIfAlreadyConnectedBefore() -> Bool{
        // Todo: check if kurvX already connected with the app before
        return false
    }
    
    private func getDeviceSerialNumber(data advertisementData: [String : Any])-> String{
        if let manufacturerData = advertisementData[CBAdvertisementDataManufacturerDataKey] as? Data {
            var data : Data
            if manufacturerData.starts(with: [0xFF, 0xFF]) {
                data = manufacturerData.dropFirst(2)
            }else{
                data = manufacturerData
            }
            if let serialNumberStr = String(data: data, encoding: .utf8) {
                var serialNumber : String = serialNumberStr
                if !serialNumberStr.starts(with: "KX") {
                    serialNumber = ("KX" + serialNumberStr)
                }
                return serialNumber
            }
        }
        return NSLocalizedString("n/a", comment: "n/a")
    }
    
    
}
