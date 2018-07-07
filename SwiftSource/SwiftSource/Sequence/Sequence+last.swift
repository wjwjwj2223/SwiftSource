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
