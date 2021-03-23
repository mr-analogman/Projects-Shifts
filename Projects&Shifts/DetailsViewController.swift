//
//  DetailsViewController.swift
//  Projects&Shifts
//
//  Created by mr_aNalogman on 21/02/2020.
//  Copyright © 2020 mr_aNalogman. All rights reserved.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var detailShiftAmount: UILabel!
    @IBOutlet weak var detailProjectRate: UILabel!
    @IBOutlet weak var detailProjectRateOver: UILabel!
    @IBOutlet weak var detailProjectTime: UILabel!
    @IBOutlet weak var detailCurrentDinner: UILabel!
    
    @IBAction func ChangeShift(segue:UIStoryboardSegue) {
        let ChangeProjectVC = segue.source as! ChangeShiftTableViewController
        let test = ChangeProjectVC.test
        print(test)
        let newBeginDate = ChangeProjectVC.beginDate
        let newEndDate = ChangeProjectVC.endDate
        let newMove = ChangeProjectVC.moving
        let newDinner = ChangeProjectVC.currentDinner
        
        changeShift(index: selectedShiftRowIndex, details: true, dateBegin: newBeginDate, dateEnd: newEndDate, move: newMove, currentDinner: newDinner)
        
        selectedShiftDateBegin = shiftArrId[selectedShiftRowIndex].value(forKey: "dateBegin") as! Date
        selectedShiftDateEnd = shiftArrId[selectedShiftRowIndex].value(forKey: "dateEnd") as! Date
        selectedShiftDinner = shiftArrId[selectedShiftRowIndex].value(forKey: "currentDinner") as? Bool ?? false
        selectedShiftMove = shiftArrId[selectedShiftRowIndex].value(forKey: "move") as! Bool
        
        let formatterDate = DateFormatter()
        formatterDate.dateFormat = NSLocalizedString("MMMM dd yyyy", comment: "")
        //let amountTextAttribute = [NSAttributedString.Key.font: ]
        self.title = formatterDate.string(from: (shiftArrId[selectedShiftRowIndex].value(forKey: "dateBegin") as! Date))
        
        detailShiftAmount.text! = NSLocalizedString("Amount: ", comment: "") + String(Int(shiftAmount(shift: shiftArrId[selectedShiftRowIndex])))
        detailProjectRate.text! = NSLocalizedString("Rate: ", comment: "") +  String(Int(shiftArrId[selectedShiftRowIndex].value(forKey: "rate") as! Double))
        detailProjectRate.text! += " (" +  String(Int(shiftArrId[selectedShiftRowIndex].value(forKey: "shiftDuration") as! Double)) + " " + NSLocalizedString("h.", comment: "") + ")"

        if (shiftArrId[selectedShiftRowIndex].value(forKey: "move") as! Bool) {
            detailCurrentDinner.text! = ""
            detailProjectTime.text! = NSLocalizedString("Move", comment: "")
            detailProjectRateOver.text! = ""
        } else {
            let formatterTime = DateFormatter()
            formatterTime.dateFormat = NSLocalizedString("h:mm a", comment: "")

            detailCurrentDinner.text! = NSLocalizedString("Dinner: ", comment: "") +  isCurrentDinner(shift: shiftArrId[selectedShiftRowIndex])
            detailProjectTime.text! = NSLocalizedString("Time: ", comment: "") + formatterTime.string(from: (shiftArrId[selectedShiftRowIndex].value(forKey: "dateBegin") as! Date)) + " - " + formatterTime.string(from: (shiftArrId[selectedShiftRowIndex].value(forKey: "dateEnd") as! Date))
            detailProjectTime.text! += " (" + String(Int(ceil(countHours(begin: shiftArrId[selectedShiftRowIndex].value(forKey: "dateBegin") as! Date, end: shiftArrId[selectedShiftRowIndex].value(forKey: "dateEnd") as! Date)))) + " " + NSLocalizedString("h.", comment: "") + ")"
            detailProjectRateOver.text! = NSLocalizedString("Processing: ", comment: "") + isRateOver(shift: shiftArrId[selectedShiftRowIndex])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.reloadInputViews()
        
        let formatterDate = DateFormatter()
        formatterDate.dateFormat = NSLocalizedString("MMMM dd yyyy", comment: "")
        //let amountTextAttribute = [NSAttributedString.Key.font: ]
        self.title = formatterDate.string(from: (shiftArrId[selectedShiftRowIndex].value(forKey: "dateBegin") as! Date))
        print("shift index in project: ", selectedShiftRowIndex)
        
        detailShiftAmount.text! += String(Int(shiftAmount(shift: shiftArrId[selectedShiftRowIndex])))
        detailProjectRate.text! += String(Int(shiftArrId[selectedShiftRowIndex].value(forKey: "rate") as! Double))
        detailProjectRate.text! += " (" +  String(Int(shiftArrId[selectedShiftRowIndex].value(forKey: "shiftDuration") as! Double)) + " " + NSLocalizedString("h.", comment: "") + ")"
        
        if (shiftArrId[selectedShiftRowIndex].value(forKey: "move") as! Bool) {
            detailCurrentDinner.text! = ""
            detailProjectTime.text! = NSLocalizedString("Move", comment: "")
            detailProjectRateOver.text! = ""
        } else {
            let formatterTime = DateFormatter()
            formatterTime.dateFormat = NSLocalizedString("h:mm a", comment: "")
            
            detailCurrentDinner.text! += isCurrentDinner(shift: shiftArrId[selectedShiftRowIndex])
            detailProjectTime.text! += formatterTime.string(from: (shiftArrId[selectedShiftRowIndex].value(forKey: "dateBegin") as! Date)) + " - " + formatterTime.string(from: (shiftArrId[selectedShiftRowIndex].value(forKey: "dateEnd") as! Date))
            detailProjectTime.text! += " (" + String(Int(ceil(countHours(begin: shiftArrId[selectedShiftRowIndex].value(forKey: "dateBegin") as! Date, end: shiftArrId[selectedShiftRowIndex].value(forKey: "dateEnd") as! Date)))) + " " + NSLocalizedString("h.", comment: "") + ")"
            detailProjectRateOver.text! +=  isRateOver(shift: shiftArrId[selectedShiftRowIndex])
            print("project name: ", projArr[selectedProjectRowIndex].value(forKey: "name") as! String)
            print("shift rate: ", shiftArrId[selectedShiftRowIndex].value(forKey: "rate") as! Double)
        }
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
