//
//  Dictionary+func.swift
//  SwiftSource
//
//  Created by 王杰 on 2018/7/10.
//  Copyright © 2018 王杰. All rights reserved.
//

import UIKit

enum Setting {
    case text(String)
    case int(Int)
    case bool(Bool)
}

func mergeTest() {
    //Dictionary 有一个 merge(_:uniquingKeysWith:)，它接受两个参数，第一个是要进行合并的键 值对，第二个是定义如何合并相同键的两个值的函数。
    let defaultSettings: [String:Setting] = [ "Airplane Mode": .bool(false), "Name": .text("My iPhone")]
    var settings = defaultSettings
    let overriddenSettings: [String:Setting] = ["Name": .text("Jane's iPhone")]
    settings.merge(overriddenSettings, uniquingKeysWith: { $1 })
    print(settings)

    //mapValues 保持字典的结构，只对其中的值进行映射
    let settingsAsStrings = settings.mapValues { setting -> String in switch setting {
    case .text(let text): return text
    case .int(let number): return String(number)
    case .bool(let value): return String(value)
        }
    }
    print(settingsAsStrings)
}


extension Dictionary {

    subscript<Result>(key:Key,as type:Result.Type) -> Result? {
        get {
            return self[key] as? Result
        }
        set {
            guard let value = newValue as? Value else {
                return
            }
            self[key] = value
        }
    }
}

func dicSubscriptTest() {
    var japan: [String: Any] = [ "name": "Japan",
                                 "capital": "Tokyo", "population": 126_740_000, "coordinates": [
                                    "latitude": 35.0,
                                    "longitude": 139.0 ]
    ]
    //(japan["coordinates"] as? [String: Double])?["coordinate"] = 36.0
    japan["coordinates", as: [String: Double].self]?["latitude"] = 36.0
    
}
