//
//  ToDoTimeCounter.swift
//  Liu Juntong
//
//  Created by Liu Juntong on 2018/4/1.
//  Copyright © 2018年 Echo. All rights reserved.
//

import Foundation

//Used for time counter (recommend part)
class ToDoTimeCounter{
    
    init() {
    }
    
    func transTimeI(time: Date) -> Int{
        let timeInterval:TimeInterval = time.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return timeStamp
    }
    
    func transTimeIT(time: Int) -> Date {
        let timeInterval:TimeInterval = TimeInterval(time)
        let date = Date(timeIntervalSince1970: timeInterval)
        return date as Date
    }
    
    func TimeCounter(beginTime: Date, endTime: Date)-> Int{
        let bt = transTimeI(time: beginTime)
        let et = transTimeI(time: endTime)
        let period = et - bt
        return period
    }
    
    func SuitableTimeCounter(FormarTaskEndTime:Date, NextTaskBeginTime:Date ,period: Int)-> Bool{
        let fet = transTimeI(time: FormarTaskEndTime)
        let nbt = transTimeI(time: NextTaskBeginTime)
        let suitable = (fet - nbt) - period
        if suitable >= 0{
            return true
        }else{
            return false
        }
    }
    
    
    
}
