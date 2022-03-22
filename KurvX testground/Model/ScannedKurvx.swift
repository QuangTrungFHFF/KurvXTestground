//
//  ScannedKurvx.swift
//  KurvX testground
//
//  Created by Trung Tran on 22.03.22.
//

import Foundation
import CoreBluetooth

class ScannedKurvX{
    var peripheral : CBPeripheral
    var serialNumber: String
    var modelNumber: String
    var rssi : Int64
    
    init(didDiscover peripheral: CBPeripheral, withSerial serialNumber: String, withModel modelNumber: String, withRSSI rssi: Int64){
        self.peripheral = peripheral
        self.serialNumber = serialNumber
        self.modelNumber = modelNumber
        self.rssi = rssi
    }
    
    func updateRSSI(newRSSI rssi : Int64){
        self.rssi = rssi
    }
}
