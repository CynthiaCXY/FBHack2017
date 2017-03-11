//
//  TableViewController.swift
//  testChat
//
//  Created by Xintong Yu on 11/03/2017.
//  Copyright © 2017 Xintong Yu. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var appList = ["Hello?", "Something important is gonna happen", "Really? I can't make it tomorrow, but I can definitely do it later later .dfsdfsdfjsdfiusdbfiusdhf iushdf shdfishdf sdf ", "alright", "what's up"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)


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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return appList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)

        // Configure the cell...
       cell.textLabel?.text = appList[indexPath.row]

        return cell
    }


    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
//     Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    }
 

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let rateAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Flag") { (action , indexPath ) -> Void in
            self.isEditing = false
            print("Vote button pressed")
        }
        
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Share") { (action , indexPath) -> Void in
            self.isEditing = false
            print("Share button pressed")
        }
        return [rateAction, shareAction]
    }
    
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
