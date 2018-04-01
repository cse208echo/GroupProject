	//
//  ToDoDAO.swift
//  Liu Juntong
//
//  Created by Liu Juntong on 2018/3/24.
//  Copyright © 2018年 Echo. All rights reserved.
//

import Foundation
import CoreData
    
    class ToDoDAO{
        var context: NSManagedObjectContext
        let now = Date()
        let timeCounter = ToDoTimeCounter.init()
        init(context: NSManagedObjectContext) {
            self.context = context
            
        }
        //Liu: Useful time transfer method
        func transTimeS(time: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            let convertedDate = dateFormatter.string(from: time)
            return convertedDate
        }
        
        func transTimeS2(time: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let convertedDate = dateFormatter.string(from: time)
            return convertedDate
        }
        
        func transTimeI(time: Date) -> Int{
            let timeInterval:TimeInterval = time.timeIntervalSince1970
            let timeStamp = Int(timeInterval)
            return timeStamp
        }
        
        func transTimeST(time: String) -> Date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            return dateFormatter.date(from: time)! as Date
        }
        
        func transTimeIT(time: Int) -> Date {
            let timeInterval:TimeInterval = TimeInterval(time)
            let date = Date(timeIntervalSince1970: timeInterval)
            return date as Date
        }
        
        //Liu：Save to database
        func saveChanges(){
            do{
                try context.save()
            }catch let error as NSError{
                print(error)
            }
        }
        
        //Liu: Add with begin time and end time
        func addWithTime(memo:String, beginTime:Date, endTime:Date, priority:Int16){
            let timeInterval:TimeInterval = now.timeIntervalSince1970
            let timeStamp = Int(timeInterval)
            let en = ToDos.entityName
            let ctx = context
            
            let e = NSEntityDescription.insertNewObject(forEntityName: en, into: ctx)
                as! ToDos
            e.memo = memo
            e.beginTime = beginTime
            e.endTime = endTime
            e.priority = priority as NSNumber?
            e.id = timeStamp as NSNumber?
            e.period = timeCounter.TimeCounter(beginTime: beginTime, endTime: endTime) as NSNumber?
            e.settingTime = now
            e.flag = false
            saveChanges()
        }
        //Liu: Add with a period of time (No begin nor end time)
        func addWithPeriod(memo:String, period: Int, priority: Int16){
            let timeInterval:TimeInterval = now.timeIntervalSince1970
            let timeStamp = Int(timeInterval)
            let en = ToDos.entityName
            let ctx = context
            let e = NSEntityDescription.insertNewObject(forEntityName: en, into: ctx)
                as! ToDos
            e.memo = memo
            e.beginTime = nil
            e.endTime = nil
            e.priority = priority as NSNumber?
            e.id = timeStamp as NSNumber?
            e.period = period as NSNumber?
            e.settingTime = now
            e.flag = false
            saveChanges()
        }
        //Liu: Get all information from database
        func getAll() -> [ToDos]{
            return get(withPredicate: NSPredicate(value: true))
        }
        //Liu: Get method.
        func get(withPredicate p:NSPredicate) -> [ToDos]{
            let en = ToDos.entityName
            let req = NSFetchRequest<NSFetchRequestResult>(entityName: en)
            req.predicate = p
            
            do{
                let resp = try context.fetch(req)
                return resp as! [ToDos]
            }catch let error as NSError{
                print(error)
                return [ToDos]()
            }
        }
        //Liu: Finish a ToDo
        func finishToDo(ID : Int) {
           let ToDosL = getByID(ID: ID)
            for t in ToDosL{
            if t.flag == false{
                t.flag = true
                t.endTime = now
            }
         }
        }
        
        //Liu: Organized by finish time, return a dictionary with date as the key, ToDo id set as the value. (Could used in Calinder)
        func organizedByDay() -> NSMutableDictionary {
            let ToDoList = getAll()
            let retDic = NSMutableDictionary()
            for i in ToDoList{
                var tempList = [Int]()
                for d in ToDoList{
                    if transTimeS2(time: i.endTime!) == transTimeS2(time: d.endTime!){
                        tempList.append(Int(truncating: d.id!))
                    }
                }
                retDic[transTimeS2(time: i.endTime!)] = tempList
            }
            return retDic
        }
        //Get Today's ToDos (Could be used in Main page)
        func getTodayToDos() -> [Int]{
            let ToDoList = getAll()
            var returnList = [Int]()
            for i in ToDoList{
                if transTimeS2(time: i.beginTime!) == transTimeS2(time: now){
                    returnList.append(Int(truncating: i.id!))
                }
            }
            return returnList
        }
        
        //Get by the end time of the ToDos
        func getByEndTime(Time : Date) -> [ToDos]{
            let ToDoList = getAll()
            var returnList = [ToDos]()
            for t in ToDoList{
                if transTimeS(time: t.endTime!) == transTimeS(time: Time) {
                    returnList.append(t)
                }
            }
            return returnList
        }
        
        //Get by the id of ToDos
        func getByID(ID : Int) -> [ToDos]{
            let p = NSPredicate(format: "id = %i",ID)
            let en = ToDos.entityName
            let req = NSFetchRequest<NSFetchRequestResult>(entityName: en)
            req.predicate = p
            
            do{
                let resp = try context.fetch(req)
                return resp as! [ToDos]
                
            }catch let error as NSError{
                print(error)
                return [ToDos]()
            }
        }
        
        //Delete by id of ToDos.
        func deletByID(Id: Int){
            let idss = getByID(ID: Id)
            for i in idss {
                context.delete(i)
            }
            saveChanges()
        }
    }
