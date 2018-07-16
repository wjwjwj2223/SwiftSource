//
//  Inout.swift
//  SwiftSource
//
//  Created by 曾婷 on 2018/7/16.
//  Copyright © 2018年 王杰. All rights reserved.
//

import UIKit

//inout 做的事情是通过值传递，然后复制回来，而并不 是传递引用

//不能够让这个 inout 参数逃逸 可以这么理解，因为 inout 的值会在函数返回之前复制回去，那么要是我们可以在函数返回之 后再去改变它，应该要怎么做呢?是说值应该在改变以后再复制吗?要是调用源已经不存在了 怎么办?编译器必须对此进行验证，因为这对保证安全十分关键。

class Inout {
    
    func increment(value: inout Int) -> Int {
        value += 1
        return value
    }
    
    func test() -> Int {
        var i = 0
        let res = self.increment(value: &i)
        return res
    }
    
}
