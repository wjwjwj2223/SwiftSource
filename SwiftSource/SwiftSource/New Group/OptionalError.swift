
//
//  OptionalError.swift
//  SwiftSource
//
//  Created by 曾婷 on 2018/7/16.
//  Copyright © 2018年 王杰. All rights reserved.
//

import UIKit

extension Optional {
    
    func or(error:Error) throws -> Wrapped {
        switch self {
        case let x?: return x
        case nil: throw error
        }
    }
    
}

enum ReadIntError:Error {
    case couldNotRead
}

func optionalErrorTest() {
    
    do {
        let int = try Int("12a").or(error: ReadIntError.couldNotRead)
    } catch {
        print(error)
    }
}
