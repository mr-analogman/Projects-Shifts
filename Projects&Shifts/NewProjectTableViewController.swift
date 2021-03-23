//
//  TableViewController.swift
//  Projects&Shifts
//
//  Created by mr_aNalogman on 30/01/2020.
//  Copyright © 2020 mr_aNalogman. All rights reserved.
//

import UIKit

class NewProjectTableViewController: UITableViewController {

    @IBOutlet weak var doneCreateProjButton: UIBarButtonItem!
    @IBOutlet weak var projName: UITextField!
    @IBOutlet weak var projRate: UITextField!
    @IBOutlet weak var projRateOver: UITextField!
    @IBOutlet weak var projShiftDuration: UITextField!
    @IBAction func projNameTextFieldChanged(_ sender: Any) {
        print("changed!")
        if (checkTextFieldIsEmpty(field: projName) && checkTextFieldIsEmpty(field: projRate) && checkTextFieldIsEmpty(field: projRateOver) && checkTextFieldIsEmpty(field: projShiftDuration)) {
            doneCreateProjButton.isEnabled = true
            print("all fields are not empty")
        } else {
            doneCreateProjButton.isEnabled = false
            print("not all fields are not empty")
        }
    }
    @IBAction func projRateTextFieldChanged(_ sender: Any) {
        print("changed!")
        if (checkTextFieldIsEmpty(field: projName) && checkTextFieldIsEmpty(field: projRate) && checkTextFieldIsEmpty(field: projRateOver) && checkTextFieldIsEmpty(field: projShiftDuration)) {
            doneCreateProjButton.isEnabled = true
            print("all fields are not empty")
        } else {
            doneCreateProjButton.isEnabled = false
            print("not all fields are not empty")
        }
    }
    @IBAction func projRateOverTextFieldChanged(_ sender: Any) {
        print("changed!")
        if (checkTextFieldIsEmpty(field: projName) && checkTextFieldIsEmpty(field: projRate) && checkTextFieldIsEmpty(field: projRateOver) && checkTextFieldIsEmpty(field: projShiftDuration)) {
            doneCreateProjButton.isEnabled = true
            print("all fields are not empty")
        } else {
            doneCreateProjButton.isEnabled = false
            print("not all fields are not empty")
        }
    }
    @IBAction func projShiftDurationTextFieldChanged(_ sender: Any) {
        print("changed!")
        if (checkTextFieldIsEmpty(field: projName) && checkTextFieldIsEmpty(field: projRate) && checkTextFieldIsEmpty(field: projRateOver) && checkTextFieldIsEmpty(field: projShiftDuration)) {
            doneCreateProjButton.isEnabled = true
            print("all fields are not empty")
        } else {
            doneCreateProjButton.isEnabled = false
            print("not all fields are not empty")
        }
    }
    
    var name: String = ""
    var rate: Double = 0
    var rateOver: Double = 0
    var duration: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        doneCreateProjButton.isEnabled = false
        projRate.keyboardType = numPad
        projRateOver.keyboardType = numPad
        projShiftDuration.keyboardType = numPad
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "doneProjectSegue") {
            name = projName.text!
            rate = Double(projRate.text!) ?? 0
            rateOver = Double(projRateOver.text!) ?? 0
            duration = Double(projShiftDuration.text!) ?? 0
        }
    }

}
