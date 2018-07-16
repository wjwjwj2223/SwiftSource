//
//  IsSubset.swift
//  SwiftSource
//
//  Created by 曾婷 on 2018/7/16.
//  Copyright © 2018年 王杰. All rights reserved.
//

import UIKit

extension Sequence where Element:Equatable {
    
    //这个 isSubset 的版本有一个重大缺陷，那就是性能。这里的算法的时间复杂度是 O(nm)，其 中 n 和 m 分别代表两个数组的元素个数。也就是说，随着输入的增多，这个函数的最坏情况的 耗时将成平方增加。这是因为 contains 在数组中的复杂度是线性的 O(m)，这个函数会迭代源 序列中的元素，逐个检查它是够匹配给定的元素。而 contains 是在另一个迭代最初数组的元素 的循环中被调用了，这个循环也很类似，是一个线性时间复杂度的循环。所以我们是在一个 O(n) 循环里执行了一个 O(m) 的循环，结果这个函数的复杂度就是 O(nm)。
    func isSubset(of other:[Element]) -> Bool {
        /// 当且仅当 `self` 中的所有元素都包含在 `other` 中，返回 true
        for element in self {
            guard other.contains(element) else {
                return false
            }
        }
        return true
    }
}

extension Sequence where Element:Hashable {
    
    //我们可以通过收紧序列元素类型的限制来写出性能更好的版本。如果我们要求元素满足 Hashable，那么我们就可以将 other 数组转换为一个 Set，这样查找操作就可以在常数时间内 进行了
    func isSubset(of other:[Element]) -> Bool {
        let otherSet = Set(other)
        for element in self {
            guard otherSet.contains(element) else {
                return false
            }
        }
        return true
    }
}

//更加通用的版本
extension Sequence {
    /// 根据序列列是否包含满⾜足给定断⾔言的元素，返回⼀一个布尔值。
    func contains(where predicate: (Element) -> Bool) -> Bool {
        for element in self {
            guard predicate(element) else {return false}
        }
        return true
    }
}

extension Sequence {
    func isSubset<S: Sequence>(of other: S,
                               by areEquivalent: (Element, S.Element) -> Bool)
    -> Bool {
            for element in self {
                guard other.contains(where: { areEquivalent(element, $0) }) else {
                    return false
                } }
            return true
    }
}
