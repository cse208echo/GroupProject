//
//  ViewController.swift
//  Liu Juntong
//
//  Created by Liu Juntong on 2018/3/19.
//  Copyright © 2018年 Echo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let dele = (UIApplication.shared.delegate as! AppDelegate)
        let context = dele.persistentContainer.viewContext
        let ToDosDAO = ToDoDAO(context: context)
        
        let users = ToDosDAO.getAll()
        for u in users{
            print("u:\(u.memo! as String),\(ToDosDAO.transTimeS(time: u.beginTime!)),\(ToDosDAO.transTimeS(time:u.endTime!)),\(u.priority as! Int),\(u.id as! Int),\(u.flag )")
        }
        
        let ToDoDic = ToDosDAO.organizedByDay()
        print(ToDoDic)
        //let TDTC = ToDoTimeCounter.init()
        
        //print(TDTC.TimeCounter(beginTime: users[1].beginTime!, endTime: users[1].endTime!))
        //print(TDTC.SuitableTimeCounter())
        print("Today ToDos: \(ToDosDAO.getTodayToDos())")
        
    }

    
    
    
    @IBAction func addToDo(_ sender: Any) {
        performSegue(withIdentifier: "addToDo", sender: sender)
    }
    
}

