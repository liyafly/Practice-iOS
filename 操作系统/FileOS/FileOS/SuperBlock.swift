
//  SuperBlock.swift
//  FileOS
//
//  Created by 李亚非 on 2017/10/29.
//  Copyright © 2017年 李亚非. All rights reserved.
//

import Foundation
class SuperBlockNode {
    var id: Int  // 5
    var count: Int  // 计数
    var next: SuperBlockNode?
    var data_blk = [Int]()     // 其他ID
    init(id: Int) {
        self.id = id
        self.count = 1
        self.next = nil
    }
}
class SuperBlock {

    var nowNode: SuperBlockNode?
    var head: SuperBlockNode?
    init(values: Int) {
        self.head = SuperBlockNode(id: values)
        self.nowNode = self.head
    }
    func revert(id: Int) {
        if self.head!.count < 5 {
            self.head!.count += 1
            self.head!.data_blk.append(id)
        }else {
            let node = SuperBlockNode(id: id)
            if self.head == nil {
                self.head = node
            }else {
                
                node.next = head
                head = node

//                self.nowNode = node
            }
        }
    }
    func apply() -> Int {
        let id = self.head?.id
        if self.head!.count == 0{
            return -1
        }else if self.head!.count > 1 {
            self.head!.count -= 1
            return (self.head?.data_blk.popLast()!)!
        }else if self.head!.count == 1 {
            if self.head!.next == nil {
                return -2
            }else {
                self.head!.count = (self.head?.next?.count)!
                self.head!.id = (self.head?.next?.id)!
                self.head!.data_blk = (self.head?.next?.data_blk)!
                self.head!.next = self.head?.next?.next
            }
        }
        return id!
    }
    func toString()  {
        var node = head
        while node != nil{
            print("count: \(node!.count)  data: \(node!.id) \(node!.data_blk)")
            node = node!.next
        }
    }
}
