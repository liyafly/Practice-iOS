//
//  PCB.swift
//  OS1
//
//  Created by 李亚非 on 2017/10/8.
//  Copyright © 2017年 李亚非. All rights reserved.
//

import Foundation

class PCB: NSObject {
    var ready = [PCB]()
    var run: PCB? = nil
    var block = [PCB]()
    var name: String
    var time: Int
    var start: Int
    var end: Int
    var size: Int

    init(name: String, time: Int, start: Int, end: Int, size: Int) {
        self.name = name
        self.time = time
        self.start = start
        self.end = end
        self.size = size
    }

   
    /// 输出
    func display() {
       // self.dispatch()
        print("PCB is name: \(name), start: \(start), end: \(end), size: \(size)")
    }
    

    /// 创建
    ///
    /// - Parameters:
    ///   - name:
    ///   - time:
    ///   - size:
    /// - Returns: BOOL
    func create(name: String, time: Int, size: Int) -> Bool {
        var start: Int
        var end: Int
        for i in 0..<memaryList.count {
            if memaryList[i].size >= size {
                start = memaryList[i].start
                if (memaryList[i].size - size) < 3 {
                    end = memaryList[i].end
                    memaryList.remove(at: i)
                } else {
                    end = memaryList[i].start + size - 1
                    memaryList[i].start = end + 1
                    memaryList[i].size = memaryList[i].end - memaryList[i].start + 1
                }
                var pcb = PCB(name: name, time: time, start: start, end: end, size: end - start + 1)
                ready.append(pcb)
                
                self.dispatch()
                return true
            }
        }
        self.dispatch()
        return false
    }
    /// 调度
    func dispatch(){
        if run == nil {
            run = self.ready.removeFirst()
        }
    }
    
    /// 终止
    ///
    /// - Returns:
    func endness() -> Bool {
        if  run == nil {
            self.dispatch()
            return false
        }
        var temp: PCB = run!
        var start = temp.start
        var end = temp.end
        var size = temp.size
        run = nil
        var flage = 0
        for i in 0..<memaryList.count {
            if ((memaryList[i].end + 1) == start) && ((memaryList[i + 1].start - 1) == end) {
                flage += 1
                memaryList[i].end = memaryList[i + 1].end
                memaryList[i].size = memaryList[i].end - memaryList[i].start + 1
                memaryList.remove(at: i + 1)
                break
            } else if (memaryList[i].end + 1) == start {
                flage += 1
                memaryList[i].end = end
                memaryList[i].size = memaryList[i].end - memaryList[i].start + 1
                break
            } else if (memaryList[i].start - 1) == end {
                flage += 1
                memaryList[i].start = start
                memaryList[i].size = memaryList[i].end - memaryList[i].start + 1
                break
            }
        }
        if flage == 0 {
            var memaryOther = Memary(start: start, end: end, size: size)
        }
        memaryList.sort{ (s1: Memary, s2: Memary) -> Bool in
             s1.size < s2.size 
        }
//        self.dispatch()
        return true
    }
    
    /// 时间片到
    func timePCB() {
        self.ready.append(run!)
        run = nil
        self.dispatch()
    }
    
    /// 阻塞
    func blocked() {
        self.block.append(self.run!)
        run = nil
        self.dispatch()
    }
    
    /// 唤醒
    func wake() {
        self.ready.append(self.block.removeFirst())
        self.dispatch()
    }
}
