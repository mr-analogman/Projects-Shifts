//
//  ProjectsTableViewController.swift
//  Projects&Shifts
//
//  Created by mr_aNalogman on 04/02/2020.
//  Copyright © 2020 mr_aNalogman. All rights reserved.
//

import UIKit
import CoreData

class ProjectsTableViewController: UITableViewController {
    
    @IBOutlet var projectsTable: UITableView!
    
    var newName: String = ""
    var newRate: Double = 0
    var newRateOver: Double = 0
    var newDuration: Double = 0
    
    @IBAction func AddNewProj(segue:UIStoryboardSegue) {
        let newProjectVC = segue.source as! NewProjectTableViewController
        newName = newProjectVC.name
        newRate = newProjectVC.rate
        newRateOver = newProjectVC.rateOver
        newDuration = newProjectVC.duration
        
        addProj(projectName: newName, projectRate: newRate, projectRateCar: 1, projectRateOver: newRateOver, projectRateDistance: 1, shiftDuration: newDuration)
        
        tableView.reloadData()
    }
    
    @IBAction func CancelNewProj(segue:UIStoryboardSegue) {
        
    }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequestProj = NSFetchRequest<NSManagedObject>(entityName: "Project")
        let fetchRequestShift = NSFetchRequest<NSManagedObject>(entityName: "Shift")
        
        do {
            projArr = try managedContext.fetch(fetchRequestProj)
            shiftArr = try managedContext.fetch(fetchRequestShift)
        } catch let error as NSError {
            print("Cannot read proj and shifts. \(error), \(error.userInfo)")
        }
        
        tableView.reloadData()
        
//        for i in 0...(shiftArr.count-1) {
//            printShift(shift: shiftArr[i])
//        }
    }

    // MARK: - Table view data source

    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    */
 
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return projArr.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let project = projArr[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = projArr[indexPath.row].value(forKey: "name") as? String

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath)
        selectedProjectRowTitle = cell!.textLabel!.text!
        selectedProjectRowId = projArr[indexPath.row].value(forKey: "id") as! Int
        selectedProjectRowIndex = /*projArr[*/indexPath.row/*].value(forKey: "id") as! Int*/
        print("selected project: ",selectedProjectRowTitle)
        print("project index: ",selectedProjectRowIndex)
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //deleteProject(at: indexPath.row)
            deleteProj(index: indexPath.row, project: projArr[indexPath.row])
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
