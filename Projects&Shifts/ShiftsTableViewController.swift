//
//  ShiftsTableViewController.swift
//  Projects&Shifts
//
//  Created by mr_aNalogman on 16/02/2020.
//  Copyright © 2020 mr_aNalogman. All rights reserved.
//

import UIKit
import CoreData

class ShiftsTableViewController: UITableViewController {
    
    @IBAction func AddNewShift(segue:UIStoryboardSegue) {
        let newProjectVC = segue.source as! NewShiftTableViewController
        
        let newBeginDate = newProjectVC.beginDate
        let newEndDate = newProjectVC.endDate
        let newMoving = newProjectVC.moving
        let newCurrentDinner = newProjectVC.currentDinner
        
        addShift(dateBegin: newBeginDate, dateEnd: newEndDate, move: newMoving, id: selectedProjectRowId, projectRate: projArr[selectedProjectRowIndex].value(forKey: "rate") as! Double, projectRateOver: projArr[selectedProjectRowIndex].value(forKey: "rateOver") as! Double, projectRateCar: 1, projectRateDistance: 1, shiftDuration: projArr[selectedProjectRowIndex].value(forKey: "shiftDuration") as! Double, currentDinner: newCurrentDinner)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Shift")

        do {
            shiftArr = try managedContext.fetch(fetchRequest)
            shiftArrWithId(id: selectedProjectRowId)
            print("Shifts in total: ",shiftArr.count)
            print("Shifts in project: ",shiftArrId.count)
        } catch let error as NSError {
            print("Cannot read shift. \(error), \(error.userInfo)")
        }

//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        
        //print(formatter.string(from: projectsArray[selectedProjectRowIndex].shiftsArray[selectedShiftRowIndex].dateBegin))
        
        tableView.reloadData()
    }
    
    @IBAction func CancelNewShift(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func ChangeProj(segue:UIStoryboardSegue) {
        let newProjectVC = segue.source as! ChangeProjectTableViewController
        let newName = newProjectVC.name
        let newRate = newProjectVC.rate
        let newRateOver = newProjectVC.rateOver
        let newDuration = newProjectVC.duration
        
        print("Old ProjName: ", projArr[selectedProjectRowIndex].value(forKey: "name") as! String)
        changeProj(projectName: newName, projectRate: newRate, projectRateCar: 1, projectRateOver: newRateOver, projectRateDistance: 1, shiftDuration: newDuration)
        print("New ProjName: ", newName);
        print("Changed ProjName: ", projArr[selectedProjectRowIndex].value(forKey: "name") as! String)
        selectedProjectRowTitle = projArr[selectedProjectRowIndex].value(forKey: "name") as! String
        self.title = selectedProjectRowTitle
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                   return
               }
               
               let managedContext = appDelegate.persistentContainer.viewContext
               
               let fetchRequestProj = NSFetchRequest<NSManagedObject>(entityName: "Project")
               
               do {
                   projArr = try managedContext.fetch(fetchRequestProj)
               } catch let error as NSError {
                   print("Cannot read proj and shifts. \(error), \(error.userInfo)")
               }
        if projArr.count > 0 {
            for i in 0...(projArr.count-1) {
                printProj(proj: projArr[i])
            }
        }
        tableView.reloadData()
    }
        
    @IBAction func CancelChangeProj(segue:UIStoryboardSegue) {
            
    }
    
//    @IBAction func ExitDetailView(segue:UIStoryboardSegue) {
//        print(selectedShiftRowIndex)
//        
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedProjectRowTitle
        print("proj id: ", projArr[selectedProjectRowIndex].value(forKey: "id") as! Int)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = selectedProjectRowTitle

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Shift")

        do {
            shiftArr = try managedContext.fetch(fetchRequest)
            shiftArrWithId(id: selectedProjectRowId)
            print("Shifts in total: ",shiftArr.count)
            print("Shifts in project: ",shiftArrId.count)
        } catch let error as NSError {
            print("Cannot read shift. \(error), \(error.userInfo)")
        }
        //print(shiftArrId)
//        if shiftArrId.count > 0 {
//            for i in 0...(shiftArrId.count-1) {
//                printShift(shift: shiftArrId[i])
//            }
//        }
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shiftArrId.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShiftCell", for: indexPath)

       let formatter = DateFormatter()
        formatter.dateFormat = NSLocalizedString("MMMM dd yyyy h:mm a", comment: "")
        
        if shiftArrId[indexPath.row].value(forKey: "move") as! Bool {
            formatter.dateFormat = NSLocalizedString("MMMM dd yyyy", comment: "")
            cell.textLabel?.text = formatter.string(from: shiftArrId[indexPath.row].value(forKey: "dateBegin") as! Date) + " " + NSLocalizedString("move", comment: "")
        } else {
            cell.textLabel?.text = formatter.string(from: shiftArrId[indexPath.row].value(forKey: "dateBegin") as! Date)
        }

        return cell
    }
    
    //var selectedShiftRowId = 0
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedShiftRowIndex = indexPath.row
        selectedShiftDateBegin = shiftArrId[indexPath.row].value(forKey: "dateBegin") as! Date
        selectedShiftDateEnd = shiftArrId[indexPath.row].value(forKey: "dateEnd") as! Date
        selectedShiftDinner = shiftArrId[indexPath.row].value(forKey: "currentDinner") as? Bool ?? false
        selectedShiftMove = shiftArrId[indexPath.row].value(forKey: "move") as! Bool
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            //projectsArray[selectedProjectRowIndex].deleteShift(at: indexPath.row)
            deleteShift(indexInArr: indexPath.row, shift: shiftArrId[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

        if (segue.identifier == "detailSegue") {
            index = selectedShiftRowId
        }
    }
    */

}
