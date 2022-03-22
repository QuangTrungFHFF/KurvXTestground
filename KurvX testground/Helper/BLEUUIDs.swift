//
//  BLEUUIDs.swift
//  KurvX testground
//
//  Created by Trung Tran on 22.03.22.
//

import Foundation
import CoreBluetooth

class BLEUUIDs{
    static func getBLEDeviceInformationServiceUUID() -> CBUUID {
        return CBUUID(string: "180A")
    }
}

