//
//  List.swift
//  SwiftSource
//
//  Created by 王杰 on 2018/7/10.
//  Copyright © 2018 王杰. All rights reserved.
//

import UIKit

//枚举实现单向链表
enum List<Element> {
    case end
    indirect case node(Element,next:List<Element>) //indirect 关键字可以告诉编译器这个枚举值 node 应该被看做引用
}

extension List {
    //头部添加元素
    func cons(_ x:Element) -> List {
        return List.node(x, next: self)
    }
}

extension List:ExpressibleByArrayLiteral {

    init(arrayLiteral elements: Element...) {
        self = elements.reversed().reduce(.end){ partialList,element in
            partialList.cons(element)
        }
    }
}

extension List {

    mutating func push(_ x:Element) {
        self = self.cons(x)
    }

    mutating func pop() -> Element? {
        switch self {
        case .end:
            return nil
        case let .node(x, next: tail):
            self = tail
            return x
        }
    }
}

extension List:IteratorProtocol,Sequence {
    mutating func next() -> Element? {
        return pop()
    }
}


func createList() {
//    List.end.cons(1).cons(2).cons(3)
    var list:List = [3,2,1]
    for x in list {
        print(x)
    }
}
