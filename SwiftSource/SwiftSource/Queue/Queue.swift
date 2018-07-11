//
//  Queue.swift
//  SwiftSource
//
//  Created by 王杰 on 2018/7/10.
//  Copyright © 2018 王杰. All rights reserved.
//

import UIKit

//实现自定义的集合类型

//设计队列协议

protocol Queue {
    //持有的元素的类型
    associatedtype Element
    //将newElement入列到self
    mutating func enqueue(_ newElement:Element)
    //从self出列一个元素
    mutating func dequeue() -> Element?
}


struct FIFOQueue<Element>:Queue {

    private var left:[Element] = []
    private var right:[Element] = []

    //将元素添加到队列最后
    mutating func enqueue(_ newElement: Element) {
        right.append(newElement)
    }

    //从队列前端移除一个元素  复杂度:平摊O(1)
    mutating func dequeue() -> Element? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        return left.popLast()
    }
}

//... 要使你的类型满足 Collection，你至少需要声明以下要求的内容:
//→ startIndex和endIndex属性
//→ 至少能够读取你的类型中的元素的下标方法
//→ 用来在集合索引之间进行步进的index(after:)方法。

extension FIFOQueue:Collection {

    public var startIndex:Int{return 0}
    public var endIndex:Int {return left.count + right.count}

    public func index(after i: Int) -> Int {
        precondition(i<endIndex)
        return i + 1
    }

    public subscript(position:Int) -> Element {
        precondition((0..<endIndex).contains(position),"index out of bounds")
        if position < left.endIndex {
            return left[left.count - position - 1]
        } else {
            return right[position-left.count]
        }
    }
}
//实现字面量协议  可使用 [value1, value2, etc] 语法创建一个队列
extension FIFOQueue:ExpressibleByArrayLiteral {

    public init(arrayLiteral elements: Element...) {
        left = elements.reversed()
        right = []
    }

}


func test() {

    var q = FIFOQueue<String>()
    for x in ["1","2","foo","3"] {
        q.enqueue(x)
    }
    for s in q {
        print(s)
    }

    var a = Array(q)
    a.append(contentsOf: q[2...3])

}

