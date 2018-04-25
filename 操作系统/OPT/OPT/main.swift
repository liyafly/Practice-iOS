//
//  main.swift
//  OPT
//
//  Created by 李亚非 on 2017/10/27.
//  Copyright © 2017年 李亚非. All rights reserved.
//

import Foundation

var fram = [Int]()
var numberoffram = 3
var referren = [7 , 0 , 1 , 2 , 0 , 3 , 0 , 4 , 2 , 3 , 0 , 3 , 2 , 1 , 2 , 0 , 1 , 7 , 0 , 1]
var array = referren
var dupical = false
var temp = 0
var getitem = Int()
var longitem = Int()
var elementinfram = false
var max = 0
var check = false
var pagefualt = 0


for element in referren {
    if let index = fram.index(of: element){
        array.removeFirst()
        print(fram)
    }
    else {
        if fram.count < numberoffram {
            fram.append(element)
            array.removeFirst()
            pagefualt += 1
        }
        else {
            for item in fram {
                
                if item == element {
                    elementinfram = true
                }
            }
            if elementinfram == false {
                for item in fram {
                    temp = 0
                    dupical = false
                    for item2 in array {
                        if item == item2 && dupical==false{
                            dupical = true
                            getitem = item2
                        }
                        else if dupical == false {
                            temp += 1
                        }
                    }
                    if max < temp {
                        longitem = getitem
                        max = temp
                    }
                    if temp == array.count {
                        longitem = item
                    }
                }
            }
            if elementinfram == false {
                let index = fram.index(of: longitem)
                fram.remove(at: index!)
                fram.append(element)
                max = 0
                pagefualt += 1
            }
            array.removeFirst()
        }
        print(fram)
    }
}
print(pagefualt)
