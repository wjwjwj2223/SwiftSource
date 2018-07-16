
//
//  KeyPath.swift
//  SwiftSource
//
//  Created by 曾婷 on 2018/7/16.
//  Copyright © 2018年 王杰. All rights reserved.
//

import UIKit

struct Address {
    var street: String
    var city: String
    var zipCode: Int
}

struct Man {
    let name: String
    var address: Address
}

let streetKeyPath = \Man.address.street
let nameKeyPath = \Man.name

func keyPathTest() {
    let simpsonResidence = Address(street: "1094 Evergreen Terrace", city: "Springfield", zipCode: 97475)
    let lisa = Man(name: "Lisa Simpson", address: simpsonResidence)
    let name = lisa[keyPath:nameKeyPath]
}

extension NSObjectProtocol where Self:NSObject {
    
    func observe<A,Other>(_ keyPath:KeyPath<Self,A>,writeTo other:Other,_ otherKeyPath:ReferenceWritableKeyPath<Other,A>) -> NSKeyValueObservation where A:Equatable,Other:NSObjectProtocol {
        return observe(keyPath, options: .new, changeHandler: { (_, change) in
            guard let newValue = change.newValue,other[keyPath:otherKeyPath] != newValue else {return}
            other[keyPath:otherKeyPath] = newValue
        })
    }
    
}


extension NSObjectProtocol where Self:NSObject {
    
    func bind<A,Other>(_ keyPath:ReferenceWritableKeyPath<Self,A>,to other:Other,_ otherKeyPath:ReferenceWritableKeyPath<Other,A>) -> (NSKeyValueObservation, NSKeyValueObservation) where A:Equatable,Other:NSObject {
        let one = observe(keyPath, writeTo: other, otherKeyPath)
        let two = other.observe(otherKeyPath, writeTo: self, keyPath)
        return (one,two)
    }
    
}

final class Sample:NSObject {
    @objc dynamic var name:String = ""
}

class MyObj:NSObject {
    @objc dynamic var test:String = ""
}

func bindTest() {
    let sample = Sample()
    let other = MyObj()
    let observation = sample.bind(\Sample.name, to: other, \.test)
    sample.name = "NEW"
    print(other.test)
    other.test = "HI"
    print(sample.name)
    
    defer {
        print("hello2")
    }
    
    defer {
        print("hello1")
    }
}


