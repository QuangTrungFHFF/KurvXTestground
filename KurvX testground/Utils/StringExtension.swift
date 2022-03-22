//
//  StringExtension.swift
//  KurvX testground
//
//  Created by Trung Tran on 22.03.22.
//

import Foundation

extension String{
    func index(from: Int) -> Index{
        return self.index(startIndex,offsetBy: from)
    }
    
    func substring(to value: Int)->String{
        let toIndex = index(from: value)
        return String(self[..<toIndex])
    }
}
