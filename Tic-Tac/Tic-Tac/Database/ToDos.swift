//
//  ToDos.swift
//  Liu Juntong
//
//  Created by Liu Juntong on 2018/3/24.
//  Copyright © 2018年 Echo. All rights reserved.
//

import Foundation
import CoreData

class ToDos: NSManagedObject{
    static let entityName = "ToDos"
    @NSManaged var memo : String?
    @NSManaged var id : NSNumber?
    @NSManaged var beginTime : Date?
    @NSManaged var endTime : Date?
    @NSManaged var priority : NSNumber?
    @NSManaged var period : NSNumber?
    @NSManaged var settingTime : Date?
    var flag = false
}
