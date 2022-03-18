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
    CREATE TABLE \(KurvxDbTable.TABLE_NAME) (
    \(DatabaseHelper._ID)\(DatabaseHelper.INTEGER_TYPE) PRIMARY KEY AUTOINCREMENT,
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
    
    let insertStatementString = """
    INSERT INTO \(KurvxDbTable.TABLE_NAME) (
    \(KurvxDbTable.COLUMN_UUID_NUMBER),
    \(KurvxDbTable.COLUMN_SERIAL_NUMBER),
    \(KurvxDbTable.COLUMN_DEVICE_NAME),
    \(KurvxDbTable.COLUMN_LAST_SELECTED),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_A00),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_A01),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_A02),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_A10),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_A11),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_A12),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_A20),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_A21),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_A22),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_PITCH),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_ROLL),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_YAW),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_MEAN_UP_X),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_MEAN_UP_Y),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_MEAN_UP_Z),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_MEAN_LEAN_X),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_MEAN_LEAN_Y),
    \(KurvxDbTable.COLUMN_DEVICE_ROT_MAT_MEAN_LEAN_Z))
    VALUE (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);
    """
    
    private override init(){
        super.init()
        peripheralsDB = self.openDatabase()
        self.createTable()
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
    
    func createTable(){
        var createTableStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(peripheralsDB, createTableString, -1, &createTableStatement, nil) == SQLITE_OK{
            if(sqlite3_step(createTableStatement) == SQLITE_DONE){
                print("\n\(KurvxDbTable.TABLE_NAME) table created!")
            }else{
                print("\nTable is not created!")
            }
        }else{
            print("\nCREATE TABLE statement is not prepared!")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func saveKurvxToLocalDatabase(){
        var insertStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(peripheralsDB, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK{
            
        }
    }
}
