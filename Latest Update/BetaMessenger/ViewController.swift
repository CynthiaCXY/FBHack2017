//
//  ViewController.swift
//  BetaMessenger
//
//  Created by KEQI LI on 12/03/2017.
//  Copyright © 2017 layforkay. All rights reserved.
//

import UIKit
import EventKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate{
    var chat = ["Hello, you there?", "Yea?", "Don't forget the report ", "alright, will do that later", "sure"]
    
    var eventStore = EKEventStore()
    //    @IBOutlet weak var myDatePicker: UIDatePicker!
    let appDelegate = UIApplication.shared.delegate
        as! AppDelegate

    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chat.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = chat[indexPath.row]
        
        
        return cell
        
    }
    @IBOutlet var tbView: UITableView!
    
    @IBOutlet var newMessage: UITextField!
    @IBAction func add(_ sender: Any) {
        let text = self.newMessage.text
        self.chat.append(text!)
        print(text ?? "123")
        self.newMessage.text = ""
        self.tbView?.reloadData()
        
    }
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        
//        if editingStyle == UITableViewCellEditingStyle.
//        
//    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        let rateAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Alarm me...") { (action , indexPath ) -> Void in
            self.isEditing = false
            let alert = UIAlertController(title: "Important message", message: "You can add this in your reminder or get alarmed!", preferredStyle: .actionSheet) // 1
            let oldColor = self.tbView.cellForRow(at:indexPath)?.textLabel?.textColor
            self.tbView.cellForRow(at:indexPath)?.textLabel?.textColor = UIColor.red
            
            let firstAction = UIAlertAction(title: "Save in Reminder for later", style: .default) { (alert: UIAlertAction!) -> Void in
                
                self.setReminder(row: indexPath.row)
            } // 2
            
            let secondAction = UIAlertAction(title: "in 1 hour", style: .default) { (alert: UIAlertAction!) -> Void in
                print("You pressed button two")
                self.setReminder(row: indexPath.row)
            } // 3
            
            let thirdAction = UIAlertAction(title: "in 2 hour", style: .default) { (alert: UIAlertAction!) -> Void in
                print("You pressed button two")
            } // 4
            
            let fourthAction = UIAlertAction(title: "Customise...", style: .default) { (alert: UIAlertAction!) -> Void in
//                self.myDatePicker.isHidden = falss
            } // 5
            
            let fifthAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert: UIAlertAction!) -> Void in
                print("You pressed button two")
                self.tbView.cellForRow(at:indexPath)?.textLabel?.textColor = oldColor
            } // 6
            
            
            
            alert.addAction(firstAction) // 4
            alert.addAction(secondAction) // 5
            alert.addAction(thirdAction)
            alert.addAction(fourthAction)
            alert.addAction(fifthAction)
            self.present(alert, animated: true, completion:nil) // 6
            
        }
        
        //        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Share") { (action , indexPath) -> Void in
        //            self.isEditing = false
        //            print("Share button pressed")
        //        }
        return [rateAction]
    }

    
    func setReminder(row:Int){
        if self.appDelegate.eventStore == nil {
            self.appDelegate.eventStore = EKEventStore()
            
            self.appDelegate.eventStore?.requestAccess(
                to: EKEntityType.reminder, completion:
                {(granted, error) in
                    if !granted {
                        print("Access to store not granted")
                    } else {
                        print("Access granted")
                    }
            })
        }
        
        if (self.appDelegate.eventStore != nil) {
            self.createReminder(lab: self.chat[row])
        }
    }
    
    func createReminder(lab:String) {
        
        let reminder = EKReminder(eventStore: appDelegate.eventStore!)
        
        reminder.title = lab
        reminder.calendar =
            appDelegate.eventStore!.defaultCalendarForNewReminders()
        let alarm = EKAlarm(relativeOffset: 10)
        
        reminder.addAlarm(alarm)
        
        do {
            try appDelegate.eventStore?.save(reminder,
                                             commit: true)
        } catch let error {
            print("Reminder failed with error \(error.localizedDescription)")
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }

}

