//
//  ViewController.swift
//  testChat
//
//  Created by KEQI LI on 12/03/2017.
//  Copyright © 2017 Xintong Yu. All rights reserved.
//

import UIKit
import EventKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tbView: UITableView!
    
    var reminderText:UITextField!
    var eventStore = EKEventStore()
//    @IBOutlet weak var myDatePicker: UIDatePicker!
    let appDelegate = UIApplication.shared.delegate
        as! AppDelegate
    
    
    var appList = ["Hello?", "Something important is gonna happen", "Really? I can't make it tomorrow, but I can definitely do it later later .dfsdfsdfjsdfiusdbfiusdhf iushdf shdfishdf sdf ", "alright", "what's up"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tbView.register(TableViewCell.self, forCellReuseIdentifier: "tableCell")
        
        tbView.delegate = self
        tbView.dataSource = self
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return appList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TableViewCell
        
        // Configure the cell...
        
//        cell.helloLabel.lineBreakMode = .byWordWrapping
//        cell.helloLabel.numberOfLines = 0
        cell.helloLabel.text = appList[indexPath.row]
        return cell
    }
    
    
     Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    //     Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let rateAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Alarm me...") { (action , indexPath ) -> Void in
            self.isEditing = false
            let alert = UIAlertController(title: "My Alert", message: "This is an action sheet.", preferredStyle: .actionSheet) // 1
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
                self.myDatePicker.isHidden = false
            } // 5
            
            let fifthAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert: UIAlertAction!) -> Void in
                print("You pressed button two")
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
            self.createReminder(lab: self.appList[row])
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
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
