//
//  main.swift
//  OS2
//
//  Created by 李亚非 on 2017/10/15.
//  Copyright © 2017年 李亚非. All rights reserved.
//

import Foundation

func mian() {
    
    print("请输入内存块数")
    let memNumber = Int(readLine()!)
    let Bitmap = bitMap.init(memNum: memNumber!)
    var page = Page(num: 0, phy: 0, p: 0, mem: memNumber!)
    print("请输入作业大小：")
    let workNumber = Int(readLine()!)
    page.createPages(number: workNumber!)
  

    Bitmap.display()

    for i in 0..<page.pageFIFO.count {
        page.pageFIFO[i].display()
    }
    while true {
        print("请输入逻辑地址")
        let inAdd = readLine()
        var addFIFO = page.FIFO(inAdd: inAdd!)
        var addLRU = page.LRU(inAdd: inAdd!)
        print("addFIFO is \(addFIFO[0]), addLRU is \(addLRU[0]) FIFO 缺页率 是\(addFIFO[1])% ,LRU 缺页率 是\(addLRU[1])%")

        for i in 0..<page.pageFIFO.count {
            page.pageFIFO[i].display()
        }
        print(" ")
        print("IndexFIFO : \(page.indexFIFO)")
        print("LRU: ")
        for i in 0..<page.pageLRU.count {
            page.pageLRU[i].display()
        }
        print(" ")
        print("IndexLRU : \(page.indexLRU)")
    }
}

mian()
