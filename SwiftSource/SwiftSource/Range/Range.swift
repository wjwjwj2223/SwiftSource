//
//  Range.swift
//  SwiftSource
//
//  Created by 王杰 on 2018/7/10.
//  Copyright © 2018 王杰. All rights reserved.
//

import UIKit

//0..<10 的类型其实是一个 CountableRange<Int>。 CountableRange 和 Range 很相似，只不过它还需要一个附加约束:它的元素类型需要遵守 Strideable 协议 (以整数为步⻓)。Swift 将这类功能更强的范围叫做可数范围，这是因为只有这 类范围可以被迭代。可数范围的边界可以是整数或者指针类型，但不能是浮点数类型，这是由 于 Stride 类型中有一个整数的约束。如果你想要对连续的浮点数值进行迭代的话，你可以通过 使用 stride(from:to:by) 和 stride(from:through:by) 方法来创建序列用以迭代。Strideable 的 约束使得 CountableRange 和 CountableClosedRange 遵守 RandomAccessCollection，于是 我们就能够对它们进行迭代了。

