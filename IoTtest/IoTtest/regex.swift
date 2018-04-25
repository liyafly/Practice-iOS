//
//  regex.swift
//  IoTTestmacOS
//
//  Created by 李亚非 on 2018/4/5.
//  Copyright © 2018年 李亚非. All rights reserved.
//

import Foundation
/// 正则匹配
///
/// - Parameters:
///   - regex: 规则
///   - text: 测试文本
/// - Returns: 匹配对应的结果数组
func matches(for regex: String, in text: String) -> [String] {
    do {
        let regex = try NSRegularExpression(pattern: regex, options: .caseInsensitive)
        let nsString = text as NSString
        let results = regex.matches(in: text, options: [], range: NSMakeRange(0, nsString.length))
        return results.map {
            nsString.substring(with: $0.range)
        }
    } catch let error {
        print("invalid regex : \(error.localizedDescription)")
        return []
    }
}
