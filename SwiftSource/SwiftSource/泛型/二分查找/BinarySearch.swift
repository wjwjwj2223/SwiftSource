//
//  BinarySearch.swift
//  SwiftSource
//
//  Created by 曾婷 on 2018/7/16.
//  Copyright © 2018年 王杰. All rights reserved.
//

import UIKit

extension Array {
    //二分查找的一种写法
    func binarySearch(for value:Element,areInIncreasingOrder:(Element,Element)-> Bool) -> Int? {
        var left = 0
        var right = count - 1
        while left <= right {
            let mid = (left + right) / 2
            let candidate = self[mid]
            if areInIncreasingOrder(candidate,value) {
                left = mid + 1
            } else if areInIncreasingOrder(value, candidate) {
                right = mid - 1
            } else {
                return mid
            }
        }
        return nil
    }
}

extension Array where Element:Comparable {
    func binarySearch(for value:Element) -> Int? {
        return self.binarySearch(for: value, areInIncreasingOrder: <)
    }
}

extension RandomAccessCollection where Index == Int, IndexDistance == Int {
    public func binarySearch(for value: Element,areInIncreasingOrder: (Element, Element) -> Bool) -> Index? {
        // 和 Array 中同样的实现... }
        return nil
    }
}



//泛型二分查找

//以整数为索引的集合的索引值其实并不一定要从零开始，最常⻅的例子就是 ArraySlice。通过 myArray[3..<5] 所创建的切片的 startIndex 将会为 3。试试看用我们的简化 版的泛型二分查找来在切片中查找结果，它将会在运行时崩溃。虽然我们可以要求索引的类型 必须是一个整数，但是 Swift 的类型系统并不能做到要求集合是从零开始的。而且就算能这么 做，加上这个限制也是一件很蠢的事情，因为我们有更好的方法。我们不应该把左右两边的索 引值相加后再除以 2，而应该找到两者之间的距离的一半，然后将这个距离加到左索引上，以 得到中点。

//  在数组非常大的情况下，将两个索引值相加有可 能会造成溢出 (比如 count 很接近 Int.max，并且要搜索的元素是数组最后一个元素 时的情况)。不过，将距离的一半加到左侧索引时，这个问题就不会发生。当然了，想 要触发这个 bug 的机会其实很小，这也是 Java 标准库中这个 bug 能隐藏如此之久的 原因所在。

extension RandomAccessCollection {
    public func binarySearch(for value:Element,areInIncreasingOrder:(Element,Element)-> Bool) -> Index? {
        guard  !isEmpty else {
            return nil
        }
        var left  = startIndex
        var right = index(before: endIndex)
        while left < right {
            let dist  = distance(from: left, to: right)
            let mid = index(left, offsetBy: dist/2)
            let candidate = self[mid]
            if areInIncreasingOrder(candidate,value) {
                left = index(after: mid)
            } else if areInIncreasingOrder(value,candidate) {
                right = index(before: mid)
            } else {
                return mid
            }
        }
        return nil
    }
}

extension RandomAccessCollection where Element:Comparable {
    func binarySearch(for value:Element) -> Index? {
        return binarySearch(for: value, areInIncreasingOrder: <)
    }
}
