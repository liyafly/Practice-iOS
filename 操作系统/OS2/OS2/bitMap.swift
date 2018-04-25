//
//  bitMap.swift
//  OS2
//
//  Created by 李亚非 on 2017/10/15.
//  Copyright © 2017年 李亚非. All rights reserved.
//

import Foundation
public class bitMap {
    var key = Array(repeating: 0, count: 64)
    static public var phyNumner = [Int]()
    static public var memNumber: Int = 0
    init(memNum: Int) {
        bitMap.memNumber = memNum
        for _ in 0..<memNum {
            var flage = 0
            let diceFaceCount = 63
            repeat {
                let a:Int = Int(arc4random()) % diceFaceCount
                if key[a] == 0 {
                    bitMap.phyNumner.append(a)
                    key[a] = 1
                    flage = 1
                }
            } while flage == 0
        }
    }
    func display() {
        print("bitMap is \(key)")
        print("pyhNumber is \(bitMap.phyNumner)")
        print("memNumber is \(bitMap.memNumber)")
    }
}
