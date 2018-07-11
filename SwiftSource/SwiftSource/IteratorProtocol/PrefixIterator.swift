//
//  PrefixIterator.swift
//  SwiftSource
//
//  Created by 王杰 on 2018/7/10.
//  Copyright © 2018 王杰. All rights reserved.
//

import UIKit

struct PrefixIterator: IteratorProtocol {

    let string:String
    var offset:String.Index

    init(string:String) {
        self.string = string
        offset = string.startIndex
    }

    mutating func next() -> Substring? {
        guard offset < string.endIndex else {
            return nil
        }
        offset = string.index(after: offset)
        return string[..<offset]
    }

}

struct PrefixSequence:Sequence {
    let string:String
    func makeIterator() -> PrefixIterator {
        return PrefixIterator(string: string)
    }
}

func prefixTest() {
    for  prefix in PrefixSequence(string:"hello") {
        print(prefix)
    }
}
