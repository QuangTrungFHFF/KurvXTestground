//
//  StorageUtils.swift
//  KurvX testground
//
//  Created by Trung Tran on 17.03.22.
//

import Foundation

public class StorageUtils{
    
    static func checkAndCreateDirectory(at path: String){
        let fm = FileManager.default
        if !fm.fileExists(atPath: path){
            do{
                try fm.createDirectory(atPath: path, withIntermediateDirectories: false, attributes: nil)
            }catch{
                print("Failed to create directory: \(error)")
            }
        }
    }
    
    static func pathForDocumentDirectoryAsUrl() -> URL?{
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        checkAndCreateDirectory(at: url.absoluteString)
        return url
    }
    
    static func getPathForDatabaseAsUrl() -> URL? {
        var url = pathForDocumentDirectoryAsUrl()!
        url.appendPathComponent("Database")
        checkAndCreateDirectory(at: url.absoluteString)
        return url
    }
}
