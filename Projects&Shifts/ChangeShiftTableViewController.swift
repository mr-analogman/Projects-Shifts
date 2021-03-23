//
//  ChangeShiftTableViewController.swift
//  Projects&Shifts
//
//  Created by mr_aNalogman on 3/20/20.
//  Copyright © 2020 mr_aNalogman. All rights reserved.
//

import UIKit
import CoreData

class ChangeShiftTableViewController: UITableViewController {

    @IBOutlet weak var dateBeginToChange: UITextField!
    @IBOutlet weak var dateEndToChange: UITextField!
    @IBOutlet weak var dinnerSwitchToChange: UISwitch!
    @IBOutlet weak var moveSwitchToChange: UISwitch!
    @IBAction func moveSwitcherToChange(_ sender: Any) {

        moveSwitchWasTurned = true
        if moveSwitchToChange.isOn == true {
            print("Move is enabled")
            dinnerSwitchToChange.setOn(false, animated: true)
            dinnerSwitchToChange.isEnabled = false
            dateEndToChange.text! = ""
            dateEndToChange.isEnabled = false
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = NSLocalizedString("MM.dd.yyyy h:mm a", comment: "")
            dateBeginToChange.text = formatter.string(from: selectedShiftDateBegin)
            dateEndToChange.text = formatter.string(from: selectedShiftDateEnd)
            dinnerSwitchToChange.isEnabled = true
            dateEndToChange.isEnabled = true
        }
    }
    
    let beginDatePicker = UIDatePicker()
    let endDatePicker = UIDatePicker()
    
    let dateFormatter = ISO8601DateFormatter()

    var moveSwitchWasTurned = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if moveSwitchToChange.isEnabled == true {
//            dateEndToChange.isEnabled = false
//        } else {
//            dateEndToChange.isEnabled = true
//        }
        tableView.allowsSelection = false
        let formatter = DateFormatter()
        formatter.dateFormat = NSLocalizedString("MM.dd.yyyy h:mm a", comment: "")
        
        //let dateFormatter = ISO8601DateFormatter()
        
        beginDatePicker.date = selectedShiftDateBegin
        endDatePicker.date = selectedShiftDateEnd
        
        dateBeginToChange.text = formatter.string(from: selectedShiftDateBegin)
        if selectedShiftMove {
            moveSwitchToChange.isOn = selectedShiftMove
        } else {
            dateEndToChange.text = formatter.string(from: selectedShiftDateEnd)
            dinnerSwitchToChange.isOn = selectedShiftDinner
        }
        
        dateBeginToChange.inputView = beginDatePicker
        dateEndToChange.inputView = endDatePicker
        beginDatePicker.datePickerMode = .dateAndTime
        endDatePicker.datePickerMode = .dateAndTime
        let localeID = Locale.preferredLanguages.first
        beginDatePicker.locale = Locale(identifier: localeID!)
        endDatePicker.locale = Locale(identifier: localeID!)
        endDatePicker.minimumDate = beginDatePicker.date
        
        beginDatePicker.addTarget(self, action: #selector(BeginDateChanged), for: .valueChanged)
        endDatePicker.addTarget(self, action: #selector(EndDateChanged), for: .valueChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TapGestureDone))
        self.view.addGestureRecognizer(tapGesture)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
    }

    @objc func BeginDateChanged() {
        GetBeginDateFromPicker()
        endDatePicker.minimumDate = beginDatePicker.date
        GetEndDateFromPicker()
    }
    @objc func EndDateChanged() {
        GetEndDateFromPicker()
    }
    
    @objc func TapGestureDone() {
        view.endEditing(true)
        //print(beginDatePicker.date)
    }
    
    func GetBeginDateFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = NSLocalizedString("MM.dd.yyyy h:mm a", comment: "")
        dateBeginToChange.text = formatter.string(from: beginDatePicker.date)
    }
    func GetEndDateFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = NSLocalizedString("MM.dd.yyyy h:mm a", comment: "")
        dateEndToChange.text = formatter.string(from: endDatePicker.date)
    }
    
    // MARK: - Table view data source

    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    */

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    var beginDate: Date = NSDate() as Date
    var endDate: Date = NSDate() as Date
    var moving: Bool = false
    var currentDinner: Bool = false
    var test: String = ""
    
    @IBAction func changeShift(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func cancelChangeShift(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "changeShiftSegue") {
            test = "Testing segue change"
            beginDate = beginDatePicker.date
            endDate = endDatePicker.date
            currentDinner = dinnerSwitchToChange.isOn
            moving = moveSwitchToChange.isOn

        }
    }
    

}
