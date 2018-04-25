//
//  main.swift
//  FileOS
//
//  Created by 李亚非 on 2017/10/29.
//  Copyright © 2017年 李亚非. All rights reserved.
//

import Foundation

func main() {
    var superBlock = SuperBlock(values: 0)
    for i in 1..<50 {
        superBlock.revert(id: i)
    }
   // superBlock.toString()
    var root = FCB()
    root.father = root
    root.name = "~"
    root.size = 1
    root.type = 2
    root.phs = [100]
    var nowFCB = root
    var string = "~"
    repeat {
        
        print("\(string) liyafei$", separator: " ", terminator: " ")
        let str = readLine()
        var strArray = str?.components(separatedBy: " ")
        switch strArray![0] {
        case "md":
            var t = 0
           for i in 0..<nowFCB.son.count {
                if nowFCB.son[i]?.name == strArray![1] && nowFCB.son[i]?.type == 2 {
                    print("已有目录请重新输入")
                    t = 1
                }
            }
            if t == 1{
                break
            }else{
                let mdFcb = FCB()
                mdFcb.father = nowFCB
                mdFcb.name = strArray?[1]
                mdFcb.size = 1
                mdFcb.type = 2
                mdFcb.phs.append(superBlock.apply())
                nowFCB.son.append(mdFcb)
                print("创建成功!")
            }
            
            break
        case "cd":
            if strArray![1] == ".." {
                nowFCB = nowFCB.father!
                string = nowFCB.name!
                break
            }
            for i in 0..<nowFCB.son.count {
                if nowFCB.son[i]?.name == strArray![1] && nowFCB.son[i]?.type == 2 {
                    nowFCB = nowFCB.son[i]!
                    string = nowFCB.name!
                    break
                }
            }
            break
        case "rd":
            for i in 0..<nowFCB.son.count {
                if nowFCB.son[i]?.name == strArray![1] && nowFCB.son[i]?.type == 2 {
                    superBlock.revert(id: (nowFCB.son[i]?.phs[0])!)
                    nowFCB.son.remove(at: i)
                    print("删除目录成功")
                    break
                }
            }
            break
        case "mk":
            var t = 0
            for i in 0..<nowFCB.son.count {
                if nowFCB.son[i]?.name == strArray![1] && nowFCB.son[i]?.type == 1 {
                    print("已有文件请重新输入")
                    t = 1
                }
            }
            if t == 1{
                break
            }else {
                let mkFCB = FCB()
                mkFCB.father = nowFCB
                mkFCB.name = strArray?[1]
                let Size = Double(strArray![2])
                let double = Double(Size! / 1024)
                let mkBit = Int(ceil(double))
                for i in 0..<mkBit {
                    mkFCB.phs.append(superBlock.apply())
                }
                mkFCB.size = Int(Size!)
                mkFCB.type = 1
                nowFCB.son.append(mkFCB)
                print("创建文件成功")
            }
            break
        case "del":
            for i in 0..<nowFCB.son.count {
                if nowFCB.son[i]?.name == strArray![1] && nowFCB.son[i]?.type == 1 {
                    var arr = nowFCB.son[i]!.phs
                    for j in 0..<arr.count {
                        superBlock.revert(id: arr[j])
                    }
                    nowFCB.son.remove(at: i)
                    print("删除文件成功！")
                    break
                }
            }
            break
        case "dir":
            for i in 0..<nowFCB.son.count {
                if nowFCB.son[i]?.type == 2 {
                    print(nowFCB.son[i]!.name!)
                }
            }
            break
        case "tree":
            FCB.tree(fcb: nowFCB, level: 1)
            break
        case "show":
            superBlock.toString()
            break
        case "ls":
            nowFCB.toString()
            break
        default: break
            
        }
    }while true
}
main()
