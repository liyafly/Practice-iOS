//
//  IO.swift
//  IoTtest
//
//  Created by 李亚非 on 2018/3/20.
//  Copyright © 2018年 李亚非. All rights reserved.
//

import Foundation
import SQLite


func createFile(name:String, fileBaseUrl:URL){
    let manager = FileManager.default
    let file = fileBaseUrl.appendingPathComponent(name)
    print("文件: \(file)")
    let exist = manager.fileExists(atPath: file.path)
    if !exist {
        let data = Data(base64Encoded:"" ,options:.ignoreUnknownCharacters)
        let createSuccess = manager.createFile(atPath: file.path,contents:data,attributes:nil)
        print("文件创建结果: \(createSuccess)")
    } else {
        let filePath:String = NSHomeDirectory() + "/Documents/test.txt"
        let info = ""
        try! info.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
    }
}
func IOtest(){
    //在文档目录下新建test.txt文件
    let manager = FileManager.default
    let urlForDocument = manager.urls( for: .documentDirectory,
                                       in:.userDomainMask)
    let url = urlForDocument[0]
    createFile(name:"test.txt", fileBaseUrl: url)
    
//    let path = "/Users/liyafei/1901.txt"
    let path1 = Bundle.main.path(forResource: "1901", ofType: "txt")
    if let aStreamReader = StreamReader(path: path1!) {
        defer {
            aStreamReader.close()
        }
        while let line = aStreamReader.nextLine() {
            let matched = matches(for: "(99999+)(\\d{4}|\\d{2})((1[0-2])|(0?[1-9]))(([12][0-9])|(3[01])|(0?[1-9]))", in: line)
            let matched1 = matches(for: "N9+(\\+|\\-+)([0-9]{2}+)([0-9]{2}+)", in: line)
            let str = matched[0].dropFirst(5)
            let yyyy = String(str.dropLast(4))
            let mmdd = String(str.dropFirst(4))
            let mm = String(StrToInt(str: String(mmdd.dropLast(2))))
            let dd = String(StrToInt(str: String(mmdd.dropFirst(2))))
            
            let manager = FileManager.default
            let urlsForDocDirectory = manager.urls(for:.documentDirectory, in:.userDomainMask)
            let docPath = urlsForDocDirectory[0]
            let file = docPath.appendingPathComponent("test.txt")
            
            let string = yyyy + "," + mm + "," + dd + "," + String(StrToInt(str: String(matched1[0].dropFirst(2)))) + "\n"
            let appendedData = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
            let writeHandler = try? FileHandle(forWritingTo:file)
            writeHandler!.seekToEndOfFile()
            writeHandler!.write(appendedData!)
        }
    }
}

    

