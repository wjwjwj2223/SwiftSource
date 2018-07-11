//
//  Sequence+function.swift
//  SwiftSource
//
//  Created by 王杰 on 2018/7/7.
//  Copyright © 2018 王杰. All rights reserved.
//

import UIKit

extension Sequence {

    //在一个逆序数组中找到第一个满足条件的元素
    func last(where predicate:(Element)->Bool) -> Element? {
        for element in reversed() where predicate(element) {
            return element
        }
        return nil
    }
    //匹配所有元素
    func all(matching predicate:(Element)->Bool) ->Bool {
        return !contains{!predicate($0)}
    }

}


extension Sequence where Element:Hashable {
    //要计算序列中某个元素出现的次数，我们可以对每个元素进行映射，将它们和 1 对应起来，然 后从得到的 (元素, 次数) 的键值对序列中创建字典。如果我们遇到相同键下的两个值 (也就是说， 我们看到了同样地元素若干次)，我们只需要将次数用 + 累加起来
    var frequencies:[Element:Int] {
        let frequencyPairs = self.map{($0,1)}
        return Dictionary.init(frequencyPairs, uniquingKeysWith: +)
    }

    //获取序列中所有的唯一元素  去重
    func unique() -> [Element] {
        var seen:Set<Element> = []
        return filter{ element in
            if seen.contains(element) {
                return false
            } else {
                seen.insert(element)
                return true
            }
        }
    }

}

func frequenciesTest() {
    let frequencies = "hello".frequencies
    let results = frequencies.filter{$0.value>1}
    print(results)
}
