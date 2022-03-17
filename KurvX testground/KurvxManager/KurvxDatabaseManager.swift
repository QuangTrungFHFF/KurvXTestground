//
//  KurvxDatabaseManager.swift
//  KurvX testground
//
//  Created by Trung Tran on 17.03.22.
//

import Foundation
import SQLite3

public class KurvxDatabaseManager : NSObject{
    
    public static let shared = KurvxDatabaseManager()
    
    private var peripheralsDB: OpaquePointer?
    private let peripheralsDBPath: String = "kurvXDb.sqlite"
    
    private override init(){
        super.init()
        peripheralsDB = self.openDatabase()
    }
    
    
    func openDatabase() -> OpaquePointer?{
        var db: OpaquePointer?
        let savingUrl = StorageUtils.getPathForDatabaseAsUrl()!.appendingPathComponent(peripheralsDBPath)
        if(sqlite3_open(savingUrl.path, &db) == SQLITE_OK){
            print("Successfully opened connection to database at \(savingUrl)")
            return db
        }else{
            print("Unable to open database.")
            return nil
        }
    }
}
