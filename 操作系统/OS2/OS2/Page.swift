//
//  Page.swift
//  OS2
//
//  Created by 李亚非 on 2017/10/15.
//  Copyright © 2017年 李亚非. All rights reserved.
//

import Foundation
extension String{
    func hexStringToInt() -> Int {
        let str = self.uppercased()
        var sum = 0
        for i in str.utf8 {
            sum = sum * 16 + Int(i) - 48 // 0-9 从48开始
            if i >= 65 {                 // A-Z 从65开始，但有初始值10，所以应该是减去55
                sum -= 7
            }
        }
        return sum
    }
}
class Page {
    var pageFIFO = [Page]()
    var pageLRU = [Page]()
    var pageOPT = [Page]()
    var indexFIFO = [Int]()
    var indexLRU = [Int]()
    var indexOPT = [Int]()
    var availableNumberFIFO: Int
    var availableNumberLRU: Int
    var availableNumberOPT: Int
    var num: Int          // 页号
    var phy: Int          // 物理快号
    var p: Int            // 状态位
    init(num: Int, phy: Int, p: Int, mem: Int) {
        self.num = num
        self.phy = phy
        self.p = p
        self.availableNumberFIFO = mem
        self.availableNumberLRU = mem
        self.availableNumberOPT = mem
    }
    func createPages(number: Int) {
        for i in 0..<number {
            let num = i
            let ph = -1
            let p = 0
            self.pageFIFO.append(Page(num: num, phy: ph, p: p, mem: bitMap.memNumber))
            self.pageLRU.append(Page(num: num, phy: ph, p: p, mem: bitMap.memNumber))
            self.pageOPT.append(Page(num: num, phy: ph, p: p, mem: bitMap.memNumber))
            self.availableNumberFIFO = bitMap.memNumber
            self.availableNumberLRU = bitMap.memNumber
            self.availableNumberOPT = bitMap.memNumber
        }
    }
    func FIFO(inAdd: String) -> [String] {
        let inadd = inAdd.hexStringToInt()
        let doub = Double(inadd / 1024)
        let last = inadd % 1024
        let inNum = Int(ceil(doub))
        var result: Int = 0
        var pagefaults = 0


        if (inNum >= self.pageFIFO.count || inNum < 0) {
            var re: [String] = ["-1.0","0.0"]
            return re
        }else {
        if self.pageFIFO[inNum].p == 1 {
            result = self.pageFIFO[inNum].phy * 1024 + last
        }else{
        if self.availableNumberFIFO > 0 {
            self.indexFIFO.append(inNum)
            pagefaults += 1
            self.pageFIFO[inNum].p = 1
            self.pageFIFO[inNum].phy = bitMap.phyNumner[bitMap.memNumber - self.availableNumberFIFO]
            self.availableNumberFIFO -= 1
            result = self.pageFIFO[inNum].phy * 1024 + last
        }else{
        
                let befor = self.indexFIFO.removeFirst()
                self.indexFIFO.append(inNum)
                self.pageFIFO[inNum].p = 1
                self.pageFIFO[inNum].phy = self.pageFIFO[befor].phy
                self.pageFIFO[befor].p = 0
                self.pageFIFO[befor].phy = -1
                pagefaults += 1
                result = self.pageFIFO[inNum].phy * 1024 + last
            }
        }
        }
        var FIFOB = ((Double( pagefaults) + Double( bitMap.memNumber)) / Double( self.pageFIFO.count)) * 100
        var re = [String]()
        
        re.append(String(result,radix: 16))
        re.append(String( FIFOB))
        return re
    }
    func LRU(inAdd: String) -> [String] {
        let inadd = inAdd.hexStringToInt()
        let doub = Double(inadd / 1024)
        let last = inadd % 1024
        let inNum = Int(ceil(doub))
        var result: Int = -1
        var pagefaults = 0
        if inNum >= self.pageLRU.count || inNum < 0 {
            var re: [String] = ["-1.0","0.0"]
            return re
        }else {
        if self.pageLRU[inNum].p == 1 {
            self.indexLRU.append(self.indexLRU.removeFirst())
            pagefaults += 1
            result = self.pageLRU[inNum].phy * 1024 + last
        }else{
        if self.availableNumberLRU > 0 {
            self.indexLRU.append(inNum)
            pagefaults += 1
            self.pageLRU[inNum].p = 1
            self.pageLRU[inNum].phy = bitMap.phyNumner[bitMap.memNumber - self.availableNumberLRU]
            self.availableNumberLRU -= 1
            result = self.pageLRU[inNum].phy * 1024 + last
        }else {
            let befor = self.indexLRU.removeFirst()
            self.indexLRU.append(inNum)
            self.pageLRU[inNum].p = 1
            self.pageLRU[inNum].phy = self.pageLRU[befor].phy
            self.pageLRU[befor].p = 0
            self.pageLRU[befor].phy = -1
            result = self.pageLRU[inNum].phy * 1024 + last
        }
        }
        }
        var re = [String]()
        re.append(String(result,radix: 16))
        var FIFOB = ((Double( pagefaults) + Double( bitMap.memNumber)) / Double( self.pageFIFO.count)) * 100
        re.append(String( FIFOB))
        return re
    }
    func display() {
        print("Page is pageNumber \(num) physicsAddress \(phy) stateBit \(p)")
    }
}
