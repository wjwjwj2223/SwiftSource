
//
//  SwiftRealize.swift
//  SwiftSource
//
//  Created by 曾婷 on 2018/7/16.
//  Copyright © 2018年 王杰. All rights reserved.
//

import UIKit

class IteratorBox<Element>:IteratorProtocol {
    
    func next() -> Element? {
        fatalError("This method is abstract")
    }
    
}

//class IteratorBoxHelper<I:IteratorProtocol> {
//    var iterator:I
//    init(iterator:I) {
//        self.iterator = iterator
//    }
//    func next() -> I.Element? {
//        return iterator.next()
//    }
//}


class IteratorBoxHelper<I:IteratorProtocol>:IteratorBox<I.Element> {
    var iterator:I
    init(iterator:I) {
        self.iterator = iterator
    }
    
    override func next() -> I.Element? {
        return iterator.next()
    }
}

func SwiftIteratorBoxtest() {
    let iter:IteratorBox = IteratorBoxHelper(iterator: [1,2,3].makeIterator())
}
