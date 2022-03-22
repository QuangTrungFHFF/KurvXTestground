//
//  KurvxDiscoveringDelegate.swift
//  KurvX testground
//
//  Created by Trung Tran on 22.03.22.
//

import Foundation
import CoreBluetooth

protocol KurvxDiscoveringDelegate{
    func onKurvxDiscovered(didDiscover peripheral: CBPeripheral, withSerial serialNumber: String, withModel modelNumber: String, withRSSI rssi: Int64)
}
