//
//  Array+map.swift
//  SwiftSource
//
//  Created by 王杰 on 2018/7/6.
//  Copyright © 2018 王杰. All rights reserved.
//

import UIKit

extension Array {

    //contains
    public func contains(where predicate: (Element) -> Bool) -> Bool {
        for element in self where predicate(element) {
            return true
        }
        return false
    }

    //map
    func map<T>(_ transform: (Element) -> T) -> [T] {
        var results:[T] = []
        results.reserveCapacity(count)
        for x in self {
            results.append(transform(x))
        }
        return results
    }

    //flatMap
    public func flatMap<T>(_ transform: (Element) -> [T]) -> [T] {
        var results:[T] = []
        for x in self {
            results.append(contentsOf: transform(x))
        }
        return results
    }

    //reduce
    func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) -> Result)  -> Result {
        var result = initialResult
        for x in self {
            result = nextPartialResult(result,x)
        }
        return result
    }

    //inout参数实现reduce
    func reduceInout<Result>( _ initialResult: inout Result, _ nextPartialResult: (inout Result, Element) -> Result) -> Result {
        for x in self {
            initialResult = nextPartialResult(&initialResult,x)
        }
        return initialResult
    }

    //累加  和reduce类似 将所有元素合并到一个数组中 并保留合并每一步的值
    func accumulate<Result>(_ initialResult:Result,_ nextPartialResult:(Result,Element)->Result) ->[Result] {
        var running = initialResult
        return map({ (next) in
            running = nextPartialResult(running,next)
            return running
        })
    }

    //过滤元素
    func filter(_ isIncluded: (Element) -> Bool) -> [Element] {

        var result = [Element]()
        for element in self where isIncluded(element) {
            result.append(element)
        }
        return result

    }

    //filter 用reduce实现 O(n2)
    func filterByReduce(_ isIncluded: (Element)  -> Bool) -> [Element] {
        return reduce([]) {
            isIncluded($1) ? $0+[$1] : $0
        }
    }

    //filter 用inout版本reduce实现 比普通reduce高效 O(n)
    func filterByInoutReduce(_ isIncluded: (Element) -> Bool) -> [Element] {
        var results = [Element]()
        return reduceInout(&results) {
            if isIncluded($1) {
                $0.append($1)
            }
            return $0
        }
    }

    //map用reduce实现
    func mapByReduce<T>(_ transform: (Element) -> T) -> [T] {
        return reduce([]) {
            $0 + [transform($1)]
        }
    }

    //使用数组首个元素作为初始值
    func reduce1(_ nextPartialResult:(Element,Element)->Element) -> Element? {
        guard let fst = first else {
            return nil
        }
        return dropFirst().reduce(fst, nextPartialResult)
    }

    //使用数组首个元素作为初始值
    func reduce2(_ nextPartialResult:(Element,Element)->Element) -> Element? {
        return first.map{
            dropFirst().reduce($0, nextPartialResult)
        }
    }



}
