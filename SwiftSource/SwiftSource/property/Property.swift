//
//  WillSetDidSet.swift
//  SwiftSource
//
//  Created by 曾婷 on 2018/7/16.
//  Copyright © 2018年 王杰. All rights reserved.
//

import UIKit

//  属性观察者必须在声明一个属性的时候就被定义，无法在扩展里进行追加。所以，这不是一 个提供给类型用戶的工具，它是专⻔为类型的设计者而设计的。willSet 和 didSet 本质上是一 对属性的简写:一个负责为值提供存储的私有存储属性，以及一个公开的计算属性。这个计算 属性的 setter 会在将值存储到存储属性中之前和/或之后，进行额外的工作。这和 Foundation 中的键值观察有本质的不同，键值观察通常是对象的消费者来观察对象内部变化的手段，而与类的设计者是否希望如此无关。



class Property {
    
}
