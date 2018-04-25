//
//  FCB.swift
//  FileOS
//
//  Created by 李亚非 on 2017/10/29.
//  Copyright © 2017年 李亚非. All rights reserved.
//

import Foundation
public class FCB {
    var father: FCB?
    var name: String?
    var size: Int
    var type: Int
    var phs: [Int]
    var son: [FCB?]
    init() {
        self.father = nil
        self.name = nil
        self.size = 0
        self.type = -1
        self.phs = [Int]()
        self.son = [FCB]()
    }
    static public func tree(fcb: FCB,level: Int){
        var temp = fcb
        for i in 0..<fcb.son.count {
            for j in 0..<level {
                print("└─", separator: "", terminator: " ")
            }
            print(fcb.son[i]!.name!)
            FCB.tree(fcb: fcb.son[i]!, level: level+1)
        }
    }
    public func toString(){
        print("FCB : father is \(father!.name!); name is \(name!) ;type is \(type); size is \(size); physical address is \(phs)")
        for i in 0..<son.count {
            son[i]!.toString()
        }
        
    }
}
