//
//  AutoClosure.swift
//  SwiftSource
//
//  Created by 曾婷 on 2018/7/16.
//  Copyright © 2018年 王杰. All rights reserved.
//

import UIKit

func and(_ l:Bool,_ r:()->Bool) -> Bool {
    guard l else {
        return false
    }
    return r()
}


func and(_ l:Bool,_ r:@autoclosure ()-> Bool) -> Bool {
    guard l else {
        return false
    }
    return r()
}

func log(ifFalse condition:Bool,message:@autoclosure ()-> String,file: String = #file, function: String = #function, line: Int = #line) {
    guard !condition else {
        return
    }
    print("Assertion failed: \(message()), \(file):\(function) (line \(line))")
}
