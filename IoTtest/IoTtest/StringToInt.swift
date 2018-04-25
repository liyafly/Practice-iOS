//
//  StringToInt.swift
//  IoTTestmacOS
//
//  Created by 李亚非 on 2018/4/5.
//  Copyright © 2018年 李亚非. All rights reserved.
//

import Foundation
/// 字符串转数字
///
/// - Parameter str: 需要转换的字符串
/// - Returns: 数字
func StrToInt(str: String) -> Int{
    //字符串不能为空
    guard str.isEmpty == false else {
        print("字符串不能为空~");
        return 0;
    }
    var s = 1
    var strInt:Int? = nil
    
    for characterInt in str.unicodeScalars {
        
        //只能包含数字或正负号
        let tempStrInt = characterInt.hashValue - "0".unicodeScalars.first!.hashValue
        guard (tempStrInt <= 9 && tempStrInt >= 0) || (characterInt.hashValue == 43 || characterInt.hashValue == 45) else {
            print("包含非法字符！");
            return 0;
        }
        //正负号只能存在于字符串开头
        if characterInt.hashValue == 43 || characterInt.hashValue == 45 {
            guard strInt == nil else {
                print("正负号只能存在于字符串开头！");
                return 0;
            }
        }
        //既然走到这一步，说明字符串合法
        //判断正负数
        if characterInt.hashValue == 43 || characterInt.hashValue == 45{
            s = s * ( 44 - characterInt.hashValue )
        }else{
            if strInt == nil {
                strInt = characterInt.hashValue - "0".unicodeScalars.first!.hashValue
            }else{
                //使用溢出运算符&*和&+避免数值过大导致溢出崩溃
                strInt = strInt! &* 10 &+ ( characterInt.hashValue - "0".unicodeScalars.first!.hashValue )
            }
        }
    }
    var result:Int? = 0
    if strInt != nil {
        result = s * strInt!
    }
    return result!;
}
