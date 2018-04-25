//
//  sqliteData.swift
//  IoTtest
//
//  Created by 李亚非 on 2018/4/6.
//  Copyright © 2018年 李亚非. All rights reserved.
//

import Foundation
import SQLite
var path = "/Users/liyafei/"
let tempt = Table("tempt")
let years = Expression<Int64>("years")
let month = Expression<Int64>("month")
let day = Expression<Int64>("day")
let time = Expression<Date>("time")
let temperature = Expression<Int64>("temperature")
func connectCreatetable(){
    
    // create parent directory iff it doesn’t exist
    try! FileManager.default.createDirectory(
        atPath: path, withIntermediateDirectories: true, attributes: nil
    )
    print(path)
    let filepath = "\(path)/db.sqlite3"
    createTable(filepath)
}
func createTable(_ filePath: String)  {
    let db = try! Connection(filePath)
    
    try! db.run(tempt.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (t) in
        t.column(years)
        t.column(month)
        t.column(day)
        t.column(time)
        t.column(temperature)
    }))
}
func inserData(yyyy: Int64, mm: Int64, dd: Int64, date: Date, temp: Int64)  {
    let path = "/Users/liyafei/db.sqlite3"
    let db = try! Connection(path)
    try! db.run(tempt.insert(years <- yyyy, month <- mm, day <- dd, time <- date, temperature <- temp))
}

//var temptArray = [[Int64]]()
//var tableArray = [Int64]()

func DataBaseIO(){
    let db = try! Connection("/Users/liyafei/db.sqlite3")
    connectCreatetable()
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMddzzz"
    let path1 = Bundle.main.path(forResource: "1901", ofType: "txt")
    try! db.run(tempt.delete())
    if let aStreamReader = StreamReader(path: path1!) {
        defer {
            aStreamReader.close()
        }
        while let line = aStreamReader.nextLine() {
            let matched = matches(for: "(99999+)(\\d{4}|\\d{2})((1[0-2])|(0?[1-9]))(([12][0-9])|(3[01])|(0?[1-9]))", in: line)
            let matched1 = matches(for: "N9+(\\+|\\-+)([0-9]{2}+)([0-9]{2}+)", in: line)
            let str = matched[0].dropFirst(5)
            let yyyy = Int64(StrToInt(str: String(str.dropLast(4))))
            let mmdd = StrToInt(str: String(str.dropFirst(4)))
            let mmdd1 = String(str.dropFirst(4))
            let mm = Int64( StrToInt(str: String(mmdd1.dropLast(2))))
            let dd = Int64( StrToInt(str: String(mmdd1.dropFirst(2))))
            let temp = Int64( StrToInt(str: String(matched1[0].dropFirst(2))))
            let str1 = String(matched[0].dropFirst(5))
            
            let strDate = str1 + "GMT"
            let DateStr = dateFormatter.date(from: strDate)
            inserData(yyyy: yyyy, mm: mm, dd: dd, date: DateStr!, temp: temp)
            
            
        }
    }
    
    
}

