//
//  Sort.swift
//  SwiftSource
//
//  Created by 王杰 on 2018/7/12.
//  Copyright © 2018 王杰. All rights reserved.
//

import UIKit

@objcMembers

final class Person:NSObject {

    let first:String
    let last:String
    let yearOfBirth:Int

    init(first:String,last:String,yearOfBirth:Int) {
        self.first = first
        self.last = last
        self.yearOfBirth = yearOfBirth
    }
}

extension NSString {

    @objc func mysort(str:NSString) -> ComparisonResult {
        if self.length > str.length {
            return .orderedAscending
        } else {
            return .orderedDescending
        }
    }
}

let peoples = [
    Person(first: "Emily", last: "Young", yearOfBirth: 2002),
    Person(first: "David", last: "Gray", yearOfBirth: 1991),
    Person(first: "Robert", last: "Barnes", yearOfBirth: 1985),
    Person(first: "Ava", last: "Barnes", yearOfBirth: 2000),
    Person(first: "Joanne", last: "Miller", yearOfBirth: 1994),
    Person(first: "Ava", last: "Barnes", yearOfBirth: 1998),
]

//先按照姓排序，再按照名排序，最后是出生年份  Objective-C方式实现
func SortTestByObjectiveC() {
    let lastDescriptor = NSSortDescriptor(key: #keyPath(Person.last), ascending: true, selector: #selector(NSString.mysort(str:)))
    let firstDescriptor = NSSortDescriptor(key: #keyPath(Person.first), ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
    let yearDescriptor = NSSortDescriptor(key: #keyPath(Person.yearOfBirth), ascending: true)
    let descriptors = [lastDescriptor,firstDescriptor,yearDescriptor]
    let results = (peoples as NSArray).sortedArray(using: descriptors) as! [Person]
    results.forEach{print($0.last +  $0.first  + "\($0.yearOfBirth)")}
}




typealias SortDescriptor<Value> = (Value,Value) -> Bool

//Swift 方式实现
func SortTestBySwift() {
    
    let sortByYearAlt:SortDescriptor<Person> = sortDescriptor(key: {$0.yearOfBirth}, by: <)
    
    let _:SortDescriptor<Person> = sortDescriptor(key: {$0.yearOfBirth})
    
    let sortByFirstName:SortDescriptor<Person> = sortDescriptor(key: {$0.first}, by: String.localizedStandardCompare)
    
    let sortByLastName:SortDescriptor<Person> = sortDescriptor(key: {$0.last}, by: String.localizedStandardCompare)
    
//    let combined:SortDescriptor<Person> = combine(sortDescriptors: [sortByLastName,sortByFirstName,sortByYearAlt])
    
    let combined = sortByYearAlt <||> sortByFirstName <||> sortByLastName
    
    let results =  peoples.sorted(by: combined)
    
    print(results)
}

func sortDescriptor<Value,Key>(key:@escaping(Value)->Key,by areInIncreasingOrder:@escaping(Key,Key)-> Bool) -> SortDescriptor<Value> {
    return {areInIncreasingOrder(key($0),key($1))}
}

func sortDescriptor<Value,Key>(key:@escaping (Value)-> Key) -> SortDescriptor<Value> where Key:Comparable {
    return {key($0) < key($1)}
}

func sortDescriptor<Value,Key>(key: @escaping(Value)-> Key,ascending:Bool = true,by comparator:@escaping (Key) -> (Key) -> ComparisonResult) -> SortDescriptor<Value> {
    return { lhs,rhs in
        let order:ComparisonResult = ascending ? .orderedAscending : .orderedDescending
        return comparator(key(lhs))(key(rhs)) == order
    }
}

func combine<Value>(sortDescriptors:[SortDescriptor<Value>]) -> SortDescriptor<Value> {
    return {lhs,rhs in
        for areInIncreasingOrder in sortDescriptors {
            if areInIncreasingOrder(lhs,rhs) {return true}
            if areInIncreasingOrder(rhs,lhs) {return false}
        }
        return false
    }
}

//-------------------------

infix operator <||>:LogicalDisjunctionPrecedence

func <||><A>(lhs:@escaping (A,A) -> Bool,rhs:@escaping (A,A)-> Bool) -> (A,A)-> Bool {
    return {x,y in
        if lhs(x,y) {return true}
        if lhs(x,y) {return false}
        if rhs(x,y) {return true}
        return false
    }
}


