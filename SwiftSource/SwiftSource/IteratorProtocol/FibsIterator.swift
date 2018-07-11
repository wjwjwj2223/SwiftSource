//
//  FibsIterator.swift
//  SwiftSource
//
//  Created by 王杰 on 2018/7/10.
//  Copyright © 2018 王杰. All rights reserved.
//

import UIKit
//斐波那契序列迭代器
struct FibsIterator: IteratorProtocol {

    var state = (0,1)

    mutating func next() -> Int? {
        let upcomingNumber = state.0
        state = (state.1,state.0+state.1)
        return upcomingNumber
    }

}

// AnyIterator 的函数来定义斐波纳契迭代器
func fibslterator() -> AnyIterator<Int> {
    var state = (0,1)
    return AnyIterator {
        let upcomingNumber = state.0
        state = (state.1,state.0+state.1)
        return upcomingNumber
    }
}


func anySequenceTest() {
    let fibsSequence = AnySequence(fibslterator)
    let arr = Array(fibsSequence.prefix(10))
    print(arr)
}

func fibsSequence2() -> Array<Int> {
    let fibsSequence2 = sequence(state: (0,1)) { (state:inout(Int,Int)) -> Int? in
        let upcomingNumer = state.0
        state = (state.1,state.0+state.1)
        return upcomingNumer
    }
    return Array(fibsSequence2.prefix(10))
}
