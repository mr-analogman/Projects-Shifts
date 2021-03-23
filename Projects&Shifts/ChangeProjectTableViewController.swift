//
//  ChangeProjectTableViewController.swift
//  Projects&Shifts
//
//  Created by mr_aNalogman on 9/7/20.
//  Copyright © 2020 mr_aNalogman. All rights reserved.
//

import UIKit

class ChangeProjectTableViewController: UITableViewController {
    
    @IBOutlet weak var projNameTextField: UITextField!
    @IBOutlet weak var projRateTextField: UITextField!
    @IBOutlet weak var projRateOverTextField: UITextField!
    @IBOutlet weak var projShiftDurationTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedProjectRowTitle
        tableView.allowsSelection = false
        projRateTextField.keyboardType = numPad
        projRateOverTextField.keyboardType = numPad
        projRateOverTextField.keyboardType = numPad
        projShiftDurationTextField.keyboardType = numPad
        
        projNameTextField.text = projArr[selectedProjectRowIndex].value(forKey: "name") as! String
        projRateTextField.text = String(Int(projArr[selectedProjectRowIndex].value(forKey: "rate") as! Double))
        projRateOverTextField.text = String(Int(projArr[selectedProjectRowIndex].value(forKey: "rateOver") as! Double))
        projShiftDurationTextField.text = String(Int(projArr[selectedProjectRowIndex].value(forKey: "shiftDuration") as! Double))
//        projRateOverTextField.keyboardType = numPad
//        projRateOverTextField.keyboardType = numPad
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//
//        // Configure the cell...
//        return cell
//    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    
    // MARK: - Navigation
    var name: String = ""
       var rate: Double = 0
       var rateOver: Double = 0
       var duration: Double = 0
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "doneChangeProjectSegue") {
            name = projNameTextField.text!
            rate = Double(projRateTextField.text!) ?? 0
            rateOver = Double(projRateOverTextField.text!) ?? 0
            duration = Double(projShiftDurationTextField.text!) ?? 0
        }
        
    }
    

}
