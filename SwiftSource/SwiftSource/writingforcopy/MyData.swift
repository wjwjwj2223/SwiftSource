//
//  MyData.swift
//  SwiftSource
//
//  Created by 王杰 on 2018/7/11.
//  Copyright © 2018 王杰. All rights reserved.
//

import UIKit

final class Box<A> {

    var unbox:A

    init(_ value:A) {
        self.unbox = value
    }

}

struct Mydata {

    private var _data:Box<NSMutableData>

    init() {
        _data = Box(NSMutableData())
    }

    init(_ data:NSData) {
        _data = Box(data.mutableCopy() as! NSMutableData)
    }

    var _dataForWriting:NSMutableData {
        mutating get {
            if !isKnownUniquelyReferenced(&_data) {
                _data = Box(_data.unbox.mutableCopy() as! NSMutableData)
                print("make a copy")
            }
            return _data.unbox
        }
    }
}


extension Mydata {

    mutating func append(_ byte:UInt8) {
        var mutableByte = byte
        _dataForWriting.append(&mutableByte, length: 1)
    }

}



//--------------------------------------------------------------------------------------
//写时复制一些陷阱

final class Empty{}

struct COWStruct {

    var ref = Empty()

    mutating func change() -> String {

        if isKnownUniquelyReferenced(&ref) {
            return "No copy"
        } else {
            return "Copy"
        }
    }
}

struct ContainerStruct<A> {

    var storage:A

    subscript(s:String) -> A {
        get {return storage}
        set {storage = newValue}
    }
}

//直接访问存储的属性，或者间接地使用下标，都可以访问到这个值。
//当我们直接访问它的时候，我们可以获取写时复制的优化，但是当我们用下标间接访问的时候，
//复制会直接发生:

func containerStructTest() {

    var d = ContainerStruct(storage: COWStruct())

    let _ = d.storage.change() //"No copy"

    let _ = d[""].change() //"copy"

//  Array 的下标使用了特别的处理，来让写时复制生效。但是其他类型都没有使用这种技术,使用下标获取值语义类型会直接复制

    //-----------------------------------

    var array = [COWStruct()]

    let _ = array[0].change() //"No copy"

    var x = array[0]

    let _ = x.change() //"copy"

    //----------------------------------

    var dict = ["key":COWStruct()]

    let _ = dict["key"]?.change() //"copy"

}
