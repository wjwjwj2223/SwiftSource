//
//  SelfProtocol.swift
//  SwiftSource
//
//  Created by 曾婷 on 2018/7/17.
//  Copyright © 2018年 王杰. All rights reserved.
//

import UIKit

protocol Equatable {
    static func ==(lhs: Self, rhs: Self) -> Bool
}


struct MonetaryAmount: Equatable {
    var currency: String
    var amountInCents: Int
    static func ==(lhs: MonetaryAmount, rhs: MonetaryAmount) -> Bool {
        return lhs.currency == rhs.currency &&
        lhs.amountInCents == rhs.amountInCents
        
    }
}

func allEqual<E: Equatable>(x: [E]) -> Bool {
    guard let firstElement = x.first else { return true }
    for element in x {
        guard element == firstElement else { return false }
    }
    return true
}

extension Collection where Element: Equatable {
    func allEqual() -> Bool {
        guard let firstElement = first else { return true }
        for element in self {
            guard element == firstElement else { return false }
        }
        return true
    }
}
