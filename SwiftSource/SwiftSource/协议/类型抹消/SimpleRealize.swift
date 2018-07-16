//
//  SimpleRealize.swift
//  SwiftSource
//
//  Created by 曾婷 on 2018/7/16.
//  Copyright © 2018年 王杰. All rights reserved.
//

import UIKit

class Intlterator {
//    在 IntIterator 中，迭代器的具体类型 (比如 ConstantIterator) 只在创建实例的时候被指 定。在那之后，这个具体类型被隐藏起来，并被闭包捕获。我们可以使用任意类型且元素为整 数的迭代器，来创建 IntIterator 实例。

    var nextImpl:() -> Int?
    init<I:IteratorProtocol>(_ iterator:I) where I.Element == Int {
        var iteratorCopy = iterator
        self.nextImpl = {iteratorCopy.next()}
    }
}

func intlteratorTest() {
//    var iter = IntIterator(ConstantIterator())
    let iter = Intlterator([1,2,3].makeIterator())
}
