//
//  addViewController.swift
//  Liu Juntong
//
//  Created by Liu Juntong on 2018/3/21.
//  Copyright © 2018年 Echo. All rights reserved.
//

import UIKit
import CoreData

class addViewController: UITableViewController{
    @IBOutlet weak var MemoEntry: UITextField!
    @IBOutlet weak var PriorityEntry: UITextField!
    @IBOutlet weak var EndTimeLabel: UILabel!
    @IBOutlet weak var BeginTimeLabel: UILabel!
    var TODO : ToDos?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ToDosDAO.deletByID(Id: 10225)
        
        /*let ids = ToDosDAO.getByID(ID: 1521887283)
        for i in ids{
        print("i:\(i.memo! as String),\(i.beginTime! as Date),\(i.endTime! as Date),\(i.priority as! Int),\(i.id as! Int),\(i.flag )")
        }*/
        
        /*let datees = ToDosDAO.getByEndTime(Time: )
        for d in datees{
            print("d:\(d.memo! as String),\(d.beginTime! as Date),\(d.endTime! as Date),\(d.priority as! Int),\(d.id as! Int),\(d.flag )")
        }*/

    }
    
    func chooseByEndT(time: Date){
        let dele = (UIApplication.shared.delegate as! AppDelegate)
        let context = dele.persistentContainer.viewContext
        let ToDosDAO = ToDoDAO(context: context)
        let datees = ToDosDAO.getByEndTime(Time: time)
        for d in datees{
            print("d:\(d.memo! as String),\(d.beginTime! as Date),\(d.endTime! as Date),\(d.priority as! Int),\(d.id as! Int),\(d.flag )")
        }
    }
    
    func transTimeS(time: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let convertedDate = dateFormatter.string(from: time)
        return convertedDate
    }
    
    func transTimeST(time: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: time)!
    }
    
    func warningEndTime(Time: Data){
        
    }
    
    @IBAction func selectBeginDate(sender: AnyObject) {
        
        let alertController:UIAlertController=UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        // 初始化 datePicker
        let datePicker = UIDatePicker( )
        // 设置样式，当前设为同时显示日期和时间
        datePicker.datePickerMode = UIDatePickerMode.dateAndTime
        // 设置默认时间
        datePicker.date = NSDate() as Date
        // 响应事件（只要滚轮变化就会触发）
        // datePicker.addTarget(self, action:Selector("datePickerValueChange:"), forControlEvents: UIControlEvents.ValueChanged)
        alertController.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.default){
            (alertAction)in
            
            self.BeginTimeLabel.text = self.transTimeS(time: datePicker.date)
            
        })
        alertController.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel,handler:nil))
        
        alertController.view.addSubview(datePicker)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func selectEndDate(sender: AnyObject) {
        
        let alertController:UIAlertController=UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        // 初始化 datePicker
        let datePicker = UIDatePicker( )
        // 设置样式，当前设为同时显示日期和时间
        datePicker.datePickerMode = UIDatePickerMode.dateAndTime
        // 设置默认时间
        datePicker.date = NSDate() as Date
        // 响应事件（只要滚轮变化就会触发）
        // datePicker.addTarget(self, action:Selector("datePickerValueChange:"), forControlEvents: UIControlEvents.ValueChanged)
        alertController.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.default){
            (alertAction)in
            self.EndTimeLabel.text = self.transTimeS(time: datePicker.date)
        })
        
        alertController.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel,handler:nil))
        alertController.view.addSubview(datePicker)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func CancelAdd(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowMainPage", sender: sender)
    }
    
    
    @IBAction func ConfirmBtn(_ sender: UIButton) {
        
        let dele = (UIApplication.shared.delegate as! AppDelegate)
        let context = dele.persistentContainer.viewContext
        let ToDosDAO = ToDoDAO(context: context)
        
        if (MemoEntry.text! != "") && (BeginTimeLabel.text! != "") && (EndTimeLabel.text! != "") && (PriorityEntry.text! != ""){
        
        if transTimeST(time: BeginTimeLabel.text!) < transTimeST(time: EndTimeLabel.text!){
            let _ = ToDosDAO.addWithTime(memo: MemoEntry.text!, beginTime: transTimeST(time: BeginTimeLabel.text!),endTime: transTimeST(time: EndTimeLabel.text!),priority:Int16(PriorityEntry.text!)!)
        ToDosDAO.saveChanges()
        performSegue(withIdentifier: "ShowMainPage", sender: sender)
        }else{
            let alertController:UIAlertController=UIAlertController(title: "You can't choose a end time before begin time!", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default))
            self.present(alertController, animated: true, completion: nil)
        }
        }else{
            let alertController:UIAlertController=UIAlertController(title: "You need to choose basic informations!", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}
