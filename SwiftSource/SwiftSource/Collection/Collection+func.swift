//
//  Collection+func.swift
//  SwiftSource
//
//  Created by 曾婷 on 2018/7/16.
//  Copyright © 2018年 王杰. All rights reserved.
//

import UIKit

extension Collection {
    
    subscript(indices indexList:Index...) -> [Element] {
        var result:[Element] = []
        for index in indexList {
            result.append(self[index])
        }
        return result
    }
    
}


func subscriptTest() {
    let indices = Array("abcdefghijklmnopqrstuvwxyz")[indices:7, 4, 11, 11, 14]
    print(indices)
}
