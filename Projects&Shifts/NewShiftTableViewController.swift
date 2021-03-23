//
//  NewShiftTableViewController.swift
//  Projects&Shifts
//
//  Created by mr_aNalogman on 21/02/2020.
//  Copyright © 2020 mr_aNalogman. All rights reserved.
//

import UIKit

class NewShiftTableViewController: UITableViewController {
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    @IBOutlet weak var doneCreateShiftButton: UIBarButtonItem!
    @IBOutlet weak var dateBegin: UITextField!
    @IBOutlet weak var dateEnd: UITextField!
    @IBOutlet weak var moveSwitch: UISwitch!
    @IBOutlet weak var currentDinnerSwitch: UISwitch!
    @IBAction func moveSwitcher(_ sender: Any) {
        if moveSwitch.isOn {
            currentDinnerSwitch.setOn(false, animated: true)
            currentDinnerSwitch.isEnabled = false
            dateEnd.text! = ""
            dateEnd.isEnabled = false
            doneCreateShiftButton.isEnabled = true
        } else {
            currentDinnerSwitch.isEnabled = true
            dateEnd.isEnabled = true
            if (dateEnd.text! == "") {
                doneCreateShiftButton.isEnabled = false
            }
        }
    }
    
    @IBAction func dateEndTextFieldTapped(_ sender: Any) {

        let formatter = DateFormatter()
        formatter.dateFormat = NSLocalizedString("MM.dd.yyyy h:mm a", comment: "")
        if dateEnd.text! == "" {
            dateEnd.text = formatter.string(from: Date())
        }
    }
    
    let beginDatePicker = UIDatePicker()
    let endDatePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        doneCreateShiftButton.isEnabled = false
        dateBegin.inputView = beginDatePicker
        dateEnd.inputView = endDatePicker
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
        let formatter = DateFormatter()
        formatter.dateFormat = NSLocalizedString("MM.dd.yyyy h:mm a", comment: "")
        dateBegin.text = formatter.string(from: beginDatePicker.date)
//        while moveSwitch.isEnabled {
//            doneCreateShiftButton.isEnabled = true
//        }
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
        doneCreateShiftButton.isEnabled = true
        
    }
    
    @objc func TapGestureDone() {
        view.endEditing(true)
        //print(beginDatePicker.date)
    }
    
    @objc func TapDateEndViewText(dateEndTextField: UITextField) {
        let formatter = DateFormatter()
        formatter.dateFormat = NSLocalizedString("MM.dd.yyyy h:mm a", comment: "")
        if dateEndTextField.text! == "" {
            dateEndTextField.text! = formatter.string(from: Date())
        }
    }
    
    func GetBeginDateFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = NSLocalizedString("MM.dd.yyyy h:mm a", comment: "")
        dateBegin.text = formatter.string(from: beginDatePicker.date)
    }
    func GetEndDateFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = NSLocalizedString("MM.dd.yyyy h:mm a", comment: "")
        dateEnd.text = formatter.string(from: endDatePicker.date)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "doneShiftSegue") {
            beginDate = beginDatePicker.date
            endDate = endDatePicker.date
            moving = moveSwitch.isOn
            currentDinner = currentDinnerSwitch.isOn
        }
    }
    

}
