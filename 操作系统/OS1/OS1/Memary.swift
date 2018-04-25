//
//  Memary.swift
//  OS1
//
//  Created by 李亚非 on 2017/10/8.
//  Copyright © 2017年 李亚非. All rights reserved.
//

import Foundation
var memaryList = [Memary]()
class Memary {
    var start: Int
    var end: Int
    var size: Int
    init?(start: Int, end: Int, size: Int) {
        if start <= 0 || end <= start || (end - start + 1) != size {
            return nil
        }
        self.start = start
        self.end = end
        self.size = size
        memaryList.append(self)
     

    }
    
    func display() {
        print("Memary start = \(start), end = \(end), size = \(size)")
    }
}


