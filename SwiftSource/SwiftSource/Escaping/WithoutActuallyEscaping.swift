//
//  WithoutActuallyEscaping.swift
//  SwiftSource
//
//  Created by 曾婷 on 2018/7/16.
//  Copyright © 2018年 王杰. All rights reserved.
//

import UIKit

extension Array {
    
    
    func all(matching predicate:@escaping (Element) -> Bool) -> Bool {
        
        return self.lazy.filter({!predicate($0)}).isEmpty
    }
    
    func allActually(matching predicate:(Element) -> Bool) -> Bool {
        return withoutActuallyEscaping(predicate) { escapablePredicate in
            self.lazy.filter { !escapablePredicate($0) }.isEmpty
        }
    }
    
    
    
}

let areAllEven = [1,2,3,4].all { $0 % 2 == 0 } // false
let areAllOneDigit = [1,2,3,4].all { $0 < 10 }
