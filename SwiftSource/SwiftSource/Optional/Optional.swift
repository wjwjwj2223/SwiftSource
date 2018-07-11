//
//  Optional.swift
//  SwiftSource
//
//  Created by 王杰 on 2018/7/10.
//  Copyright © 2018 王杰. All rights reserved.
//

import UIKit

class OptionalTest {

    //Optional<Optional<Int>>
    static func optionalIterator() {
        let stringNumbers = ["1","2","three"]
        let maybeInts = stringNumbers.map{Int($0)}
        for maybeInt in maybeInts {
            //maybeInt是一个Int？
        }
        for case let i? in maybeInts {
            print(i)
        }

        for case let .some(i) in maybeInts {
            print(i)
        }

        for i in maybeInts where i != nil {
            print("\(i)"+"where")
        }

        for case nil in maybeInts {
            print("no value")
        }
    }

    static func caseTest() {
        if case 0..<10 = 8 {
            print("case1")
        }
        if case "8" = "8" {
            print("case2")
        }
    }

    //可选链
    static func optionchiain() {
        let s1:String?? = nil
        let res1 = (s1 ?? "inner") ?? "outer"
        print(res1) //inner
        let s2:String?? = .some(nil)
        let res2 = (s2 ?? "inner") ?? "outer"
        print(res2) //outer
    }
}
