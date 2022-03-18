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
    
    let createTableString = """
    CREATE TABLE \(KurvxDbTable.TABLE_NAME)(
    \(KurvxDbTable.COLUMN_UUID_NUMBER)\(DatabaseHelper.INTEGER_TYPE) PRIMARY KEY AUTOINCREMENT,
    \(KurvxDbTable.COLUMN_UUID_NUMBER)\(DatabaseHelper.TEXT_TYPE)\(DatabaseHelper.NOT_NULL)\(DatabaseHelper.UNIQUE),
    \(KurvxDbTable.COLUMN_SERIAL_NUMBER)\(DatabaseHelper.TEXT_TYPE)\(DatabaseHelper.NOT_NULL)\(DatabaseHelper.UNIQUE),
    \(KurvxDbTable.COLUMN_DEVICE_NAME)\(DatabaseHelper.TEXT_TYPE),
    \(KurvxDbTable.COLUMN_LAST_SELECTED)\(DatabaseHelper.BOOLEAN_TYPE),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_A00)\(DatabaseHelper.FLOAT_TYPE),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_A01)\(DatabaseHelper.FLOAT_TYPE),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_A02)\(DatabaseHelper.FLOAT_TYPE),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_A10)\(DatabaseHelper.FLOAT_TYPE),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_A11)\(DatabaseHelper.FLOAT_TYPE),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_A12)\(DatabaseHelper.FLOAT_TYPE),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_A20)\(DatabaseHelper.FLOAT_TYPE),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_A21)\(DatabaseHelper.FLOAT_TYPE),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_A22)\(DatabaseHelper.FLOAT_TYPE),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_PITCH)\(DatabaseHelper.FLOAT_TYPE),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_ROLL)\(DatabaseHelper.FLOAT_TYPE),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_YAW)\(DatabaseHelper.FLOAT_TYPE),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_MEAN_UP_X)\(DatabaseHelper.FLOAT_TYPE),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_MEAN_UP_Y)\(DatabaseHelper.FLOAT_TYPE),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_MEAN_UP_Z)\(DatabaseHelper.FLOAT_TYPE),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_MEAN_LEAN_X)\(DatabaseHelper.FLOAT_TYPE),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_MEAN_LEAN_Y)\(DatabaseHelper.FLOAT_TYPE),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_MEAN_LEAN_Z)\(DatabaseHelper.FLOAT_TYPE));
    """
    
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
