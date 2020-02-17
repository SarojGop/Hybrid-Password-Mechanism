//
//  DBManager.swift
//  Login
//
//  Created by Saroj Gopali on 11/20/18.
//  Copyright © 2018 Saroj Gopali. All rights reserved.
//

import UIKit
import SQLite3
var db:OpaquePointer?/*

class DBManager: NSObject {
    
    let fileurl = try!FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("login.sqlite")
    if sqlite3_open(fileurl.path, &db) != SQLITE_OK{
    print("Error Opening Database")
    }
    if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Heroes (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, powerrank INTEGER)", nil, nil, nil) != SQLITE_OK {
    let errmsg = String(cString: sqlite3_errmsg(db)!)
    print("error creating table: \(errmsg)")
    }
    
    //getting values from textfields
    let name = userNameR.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    let powerRanking = passwordRe.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    
    
    //validating that values are not empty
    if(name?.isEmpty)!{
    userNameR.layer.borderColor = UIColor.red.cgColor
    return
    }
    
    if(powerRanking?.isEmpty)!{
    passwordRe.layer.borderColor = UIColor.red.cgColor
    return
    }
    
    //creating a statement
    var stmt: OpaquePointer?
    
    //the insert query
    let queryString = "INSERT INTO  (name, password) VALUES (?,?)"
    
    //preparing the query
    if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
    let errmsg = String(cString: sqlite3_errmsg(db)!)
    print("error preparing insert: \(errmsg)")
    return
    }
    
    //binding the parameters
    if sqlite3_bind_text(stmt, 1, name, -1, nil) != SQLITE_OK{
    let errmsg = String(cString: sqlite3_errmsg(db)!)
    print("failure binding name: \(errmsg)")
    return
    }
    
    if sqlite3_bind_int(stmt, 2, (powerRanking! as NSString).intValue) != SQLITE_OK{
    let errmsg = String(cString: sqlite3_errmsg(db)!)
    print("failure binding name: \(errmsg)")
    return
    }
    
    //executing the query to insert values
    if sqlite3_step(stmt) != SQLITE_DONE {
    let errmsg = String(cString: sqlite3_errmsg(db)!)
    print("failure inserting hero: \(errmsg)")
    return
    }
    
    //emptying the textfields
    userNameR.text=""
    passwordRe.text=""
    
    
    // readValues()
    
    //displaying a success message
    print("Saved Su")
*/
//}
