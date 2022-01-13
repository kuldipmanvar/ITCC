//
//  DBHelper.swift
//  ITCCKuldipTest
//
//  Created by Kuldip Mac on 13/01/22.
//

import Foundation
import SQLite3

class DBHelper
{
    init()
    {
        db = openDatabase()
        createTable()
    }

    let dbPath: String = "myDb.sqlite"
    var db:OpaquePointer?

    //MARK: Database Fire Method
    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    
    
    
    
    //MARK : Create Table Funcrtion
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS items(Id INTEGER PRIMARY KEY,is_first_time INTEGER,profile_pic text,type text,dob text,last_name text,user_type INTEGER,email text,useriD INTEGER,gender text,first_name text,role_name text);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("items table created.")
            } else {
                print("items table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    //MARK : Insert Query Method
    func insert(id:Int, is_first_time:Int, profile_pic:String,type:String,dob: String,last_name:String,user_type:Int,email:String,iD:Int,gender:String,first_name:String,role_name:String)
    {
        let persons = read()
        for p in persons
        {
            if p.id == id
            {
                return
            }
        }
        let insertStatementString = "INSERT INTO items (Id, is_first_time, profile_pic, type, dob, last_name, user_type, email, useriD, gender, first_name, role_name) VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
//            sqlite3_bind_text(insertStatement, 1, (name as NSString).utf8String, -1, nil)
//            sqlite3_bind_int(insertStatement, 2, Int32(age))
            sqlite3_bind_int(insertStatement, 1, Int32(is_first_time))
          //  sqlite3_bind_text(insertStatement, 1, (is_first_time as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (profile_pic as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (type as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (dob as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (last_name as NSString).utf8String, -1, nil)

            sqlite3_bind_int(insertStatement, 6, Int32(user_type))
            sqlite3_bind_text(insertStatement, 7, (email as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 8, Int32(id))
            sqlite3_bind_text(insertStatement, 9, (gender as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 10, (first_name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 11, (role_name as NSString).utf8String, -1, nil)

            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    //MARK: Table record Query Method
    func read() -> [items] {
        let queryStatementString = "SELECT * FROM items;"
        var queryStatement: OpaquePointer? = nil
        var psns : [items] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
              //  let id = sqlite3_column_int(queryStatement, 0)
                let is_first_time = sqlite3_column_int(queryStatement, 1)
                let profile_pic = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let type = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))

                
                let dob = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let last_name = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let user_type = sqlite3_column_int(queryStatement, 6)

                let email = String(describing: String(cString: sqlite3_column_text(queryStatement, 7)))
                let userID = sqlite3_column_int(queryStatement, 8)
                let gender = String(describing: String(cString: sqlite3_column_text(queryStatement, 9)))
                let first_name = String(describing: String(cString: sqlite3_column_text(queryStatement, 10)))
                let role_name = String(describing: String(cString: sqlite3_column_text(queryStatement, 11)))

                
                
                
                
                psns.append(items(is_first_time: "\(is_first_time)", profile_pic: "\(profile_pic)", type: "\(type)", dob: "\(dob)", last_name: "\(last_name)", user_type: Int(user_type), email: "\(email)", id: Int(userID), gender: "\(gender)", first_name: "\(first_name)", role_name: "\(role_name)"))
                //psns.append(items(id: Int(id), name: name, age: Int(year), number: number))
                print("Query Result:")
                print("\(email) | \(role_name) | \(user_type)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
   
}
