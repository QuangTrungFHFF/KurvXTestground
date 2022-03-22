//
//  KurvxUUIDs.swift
//  KurvX testground
//
//  Created by Trung Tran on 15.03.22.
//

import Foundation
import CoreBluetooth

//MARK: - KurvX Base Identifier formats
let baseUUIDFormat  : String = "0025%@-708C-11E4-948B-8C89A55D403C"

//MARK: Kurvx Base Service
func getBaseServiceUUID() -> CBUUID {
    return getUUIDString(withBaseFormat: baseUUIDFormat, andIdentifier: "0000")
}

//MARK: - UUID generation helper
fileprivate func getUUIDString(withBaseFormat aBaseFormat: String, andIdentifier anIdentifier: String) -> CBUUID {
    let uuidString = String(format: aBaseFormat, anIdentifier)
    return CBUUID(string: uuidString)
}

let kurvx_device_model_supported = ["kurvX_1"]
