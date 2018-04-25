//
//  main.swift
//  OS1
//
//  Created by 李亚非 on 2017/10/8.
//  Copyright © 2017年 李亚非. All rights reserved.
//

import Foundation
let PCBone = PCB(name: "1", time: 1, start: 1, end: 2, size: 1)
func displayBlock(){
    if PCBone.block.isEmpty {
        print(" ")
    }
    for i in 0..<PCBone.block.count {
        print(PCBone.block[i].display(), separator: " ", terminator: " ")
    }
}
func displayRun(){
    if PCBone.run == nil {
        print("无")
    }
    print(PCBone.run?.display())
}
func displayReady(){
    if PCBone.ready.isEmpty {
        print(" ")
    }
    for i in 0..<PCBone.ready.count {
        print(PCBone.ready[i].display(), separator: " ", terminator: " ")
    }
}
func displayAll(){
    print("run: ", separator: "", terminator: "")
    displayRun()
    print("ready: ", separator: "", terminator: "")
    displayReady()
    print("block: ", separator: "", terminator: "")
    displayBlock()
    for i in 0..<memaryList.count{
        print(memaryList[i].display(), separator: "", terminator: "")
    }
}
func mian(){
    while true {
        print("请输入首尾地址，即初始化内存长度")
        var start = Int(readLine()!)!
        var end = Int(readLine()!)!
        var memaryR = Memary(start: start, end: end, size: (end - start + 1))
        if memaryR?.size == 0 {
            print("错误")
            continue
        }else {
            break
        }
    }
    var opeart = ""
    while opeart != "0" {
        print("1--创建进程")
        print("2--终止进程")
        print("3--模拟时间片到")
        print("4--阻塞进程")
        print("5--唤醒进程")
        print("0--推出")
        print("请输入要进行的操作")
       
        opeart = readLine()!
        switch opeart {
            case "1":
                print("请输入进程名：")
                var name = readLine()!
                var time = 1
                print("请输入进程大小：")
                var size = Int(readLine()!)!
                PCBone.create(name: name, time: time, size: size)
                PCBone.dispatch()
                displayAll()
            case "2":
                let string = "终止进程" + (PCBone.endness() ? "成功" : "失败")
                print(string)
//                PCBone.dispatch()
                displayAll()
            case "3":
                PCBone.timePCB()
                PCBone.dispatch()
                displayAll()
            case "4":
                PCBone.blocked()
                PCBone.dispatch()
                displayAll()
            case "5":
                PCBone.wake()
                PCBone.dispatch()
                displayAll()
            case "0":
               opeart = "0"
            default:
                print("错误")
        }
    }
}
mian()

