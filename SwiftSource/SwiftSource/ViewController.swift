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
        let b = self.compareWithAddp(People.addperson, people1: People(name:"wj") , people2: People(name:"zt"))
        print(b)
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
    
//------------------------------------------------------------
    
    //方法声明为函数类型
    
    let sort:(String)->(String)->ComparisonResult = String.localizedStandardCompare
    
    let equal:(String)->(String)->Bool = String.hasPrefix
    
    let addp:(People)->(People)->Bool = People.addperson
    
    func compareWithAddp(_ addp:(People)->(People)->Bool,people1:People,people2:People) -> Bool {
        return addp(people1)(people2)
    }
    
    
}


class People {
    
    var name:String?
    init(name:String) {
        self.name = name
    }
    func addperson(p:People) -> Bool {
        if self.name == p.name {
            return true
        }
        return false
    }
}
