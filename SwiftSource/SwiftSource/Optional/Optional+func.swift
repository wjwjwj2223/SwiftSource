//
//  Optional+func.swift
//  SwiftSource
//
//  Created by 王杰 on 2018/7/10.
//  Copyright © 2018 王杰. All rights reserved.
//

import UIKit

extension Optional {

    //  map实现  注意:如果你对一个可选值调用 map，但是你的转换函数本身也返回可选值结果的话，最终 结果将是一个双重嵌套的可选值
    func map<U>(transform:(Wrapped)->U) -> U? {
        if let value = self {
            return transform(value)
        }
        return nil
    }

    //flatmap可以将可选结果展平
    func flatMap<U>(transform:(Wrapped)->U?) -> U? {

        if let value = self, let transformed = transform(value) {
            return transformed
        }
        return nil

    }

}
