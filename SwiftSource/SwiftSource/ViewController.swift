//
//  ViewController.swift
//  SwiftSource
//
//  Created by 王杰 on 2018/7/6.
//  Copyright © 2018 王杰. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        SortTestBySwift()
    }

    //展平数组
    func flattenMap() {
        let res =  [[1,2],[3,4]].flatMap{$0.map{$0}}
        print(res)//[1,2,3,4]
    }

    //合并数组
    func combineMap() {
        let array1 = [1,2]
        let array2 = [3,4]
        let result = array1.flatMap { a in
            array2.map{ b in
                (a,b)
            }
        }
        print(result)//[(1,3),(1,4),(2,3),(2,4)]
    }

    func test() {

    }
    
    
}

