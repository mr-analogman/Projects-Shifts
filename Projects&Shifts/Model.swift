//
//  Model.swift
//  Projects&Shifts
//
//  Created by mr_aNalogman on 29/01/2020.
//  Copyright © 2020 mr_aNalogman. All rights reserved.
//

import Foundation
import UIKit
import CoreData

let numPad = UIKeyboardType.numberPad

var projArr: [NSManagedObject] = []
var projectShiftsIndex: [Int] = []
var shiftArr: [NSManagedObject] = []
var shiftArrId: [NSManagedObject] = []
var shiftArrIdIndex: [Int] = []

var selectedProjectRowTitle: String = ""
var selectedProjectRowIndex: Int = 0
var selectedProjectRowId: Int = 0
var selectedShiftRowIndex: Int = 0
var selectedShiftDateBegin: Date = NSDate() as Date
var selectedShiftDateEnd: Date = NSDate() as Date
var selectedShiftDinner: Bool = false
var selectedShiftMove: Bool = false


var projId: Int {
    get {
        if projArr.count > 0 {
            return (projArr[projArr.count-1].value(forKey: "id") as! Int) + 1
        } else {
            return 0
        }
    }
}



var projArrTest: [NSManagedObject] = []

func deleteProj(index: Int, project: NSManagedObject) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
    }
    
    let managedContext = appDelegate.persistentContainer.viewContext
    let id = project.value(forKey: "id") as! Int
    //shiftArrWithId(id: project.value(forKey: "id") as! Int)
    for i in stride(from: (shiftArr.count-1), through: 0, by: -1)  {
        if shiftArr[i].value(forKey: "id") as? Int == id {
            
            print("removed: ", i)
            managedContext.delete(shiftArr[i])
            shiftArr.remove(at: i)
        } else {
            print(i)
        }
    }
    
    managedContext.delete(project)
    do {
        try managedContext.save()
    } catch let error as NSError {
        fatalError("Cannot to delete proj. \(error), \(error.userInfo)")
    }
    
    let fetchRequestProj = NSFetchRequest<NSManagedObject>(entityName: "Project")
    
    do {
        projArr = try managedContext.fetch(fetchRequestProj)
    } catch let error as NSError {
        print("Cannot read proj and shifts. \(error), \(error.userInfo)")
    }
    print("Projects after deleting: ", projArr.count)
    
//    for i in index...(projArr.count-1) {
//        projArr[i].setValue(i-1, forKey: "id")
//    }
    
    //projArr.remove(at: index)
}

func addProj(projectName: String, projectRate: Double, projectRateCar: Double, projectRateOver: Double, projectRateDistance: Double, shiftDuration: Double) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
    }
    
    let managedContext = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "Project", in: managedContext)!
    let project = NSManagedObject(entity: entity, insertInto: managedContext)
    
    project.setValue(projId, forKey: "id")
    project.setValue(projectName, forKey: "name")
    project.setValue(projectRate, forKey: "rate")
    project.setValue(projectRateOver, forKey: "rateOver")
    project.setValue(projectRateCar, forKey: "rateCar")
    project.setValue(projectRateDistance, forKey: "rateDistance")
    project.setValue(shiftDuration, forKey: "shiftDuration")
    
    do {
        try managedContext.save()
        projArr.append(project)
    } catch let error as NSError {
        fatalError("Cannot to write. \(error), \(error.userInfo)")
    }
    //projId += 1
}

func changeProj(projectName: String, projectRate: Double, projectRateCar: Double, projectRateOver: Double, projectRateDistance: Double, shiftDuration: Double) {
    projArr[selectedProjectRowIndex].setValue(projectName, forKey: "name")
    projArr[selectedProjectRowIndex].setValue(projectRate, forKey: "rate")
    projArr[selectedProjectRowIndex].setValue(projectRateOver, forKey: "rateOver")
    projArr[selectedProjectRowIndex].setValue(projectRateCar, forKey: "rateCar")
    projArr[selectedProjectRowIndex].setValue(projectRateDistance, forKey: "rateDistance")
    projArr[selectedProjectRowIndex].setValue(shiftDuration, forKey: "shiftDuration")
    
    for i in 0...(shiftArrId.count-1) {
        changeShift(index: i, details: false, dateBegin: Date(), dateEnd: Date(), move: false, projectRate: projectRate, projectRateOver: projectRateOver, projectRateCar: projectRateCar, projectRateDistance: projectRateDistance, shiftDuration: shiftDuration, currentDinner: false)
    }
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
    }

    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequestProj = NSFetchRequest<NSManagedObject>(entityName: "Project")
    let fetchRequestShift = NSFetchRequest<NSManagedObject>(entityName: "Shift")
    
    
    do {
        try managedContext.save()
        projArr = try managedContext.fetch(fetchRequestProj)
        shiftArr = try managedContext.fetch(fetchRequestShift)
        shiftArrWithId(id: selectedProjectRowId)
    } catch let error as NSError {
        print("Cannot change proj. \(error), \(error.userInfo)")
    }
    
}

func deleteShift(indexInArr: Int,shift: NSManagedObject) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
    }
    
    let managedContext = appDelegate.persistentContainer.viewContext
    managedContext.delete(shift)
    
    shiftArrId.remove(at: indexInArr)
    shiftArr.remove(at: shiftArrIdIndex[indexInArr])
    do {
        try managedContext.save()
    } catch let error as NSError {
        fatalError("Cannot to delete shift. \(error), \(error.userInfo)")
    }
    
}

func addShift(dateBegin: Date, dateEnd: Date, move: Bool, id: Int, projectRate: Double, projectRateOver: Double, projectRateCar: Double, projectRateDistance: Double, shiftDuration: Double, currentDinner: Bool) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
    }
    
    let managedContext = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "Shift", in: managedContext)!
    let shift = NSManagedObject(entity: entity, insertInto: managedContext)
    
    shift.setValue(id, forKey: "id")
    shift.setValue(dateBegin, forKey: "dateBegin")
    shift.setValue(dateEnd, forKey: "dateEnd")
    shift.setValue(move, forKey: "move")
    shift.setValue(projectRate, forKey: "rate")
    shift.setValue(projectRateOver, forKey: "rateOver")
    shift.setValue(projectRateCar, forKey: "rateCar")
    shift.setValue(projectRateDistance, forKey: "rateDistance")
    shift.setValue(shiftDuration, forKey: "shiftDuration")
    shift.setValue(currentDinner, forKey: "currentDinner")
    
    do {
        try managedContext.save()
        shiftArr.append(shift)
    } catch let error as NSError {
        fatalError("Cannot to write. \(error), \(error.userInfo)")
    }
}

func changeShift(index: Int, details: Bool, dateBegin: Date = Date(), dateEnd: Date = Date(), move: Bool = false, projectRate: Double = 0, projectRateOver: Double = 0, projectRateCar: Double = 0, projectRateDistance: Double = 0, shiftDuration: Double = 0, currentDinner: Bool = false) {
    
    if details {
        shiftArrId[index].setValue(dateBegin, forKey: "dateBegin")
        shiftArrId[index].setValue(dateEnd, forKey: "dateEnd")
        shiftArrId[index].setValue(move, forKey: "move")
        shiftArrId[index].setValue(currentDinner, forKey: "currentDinner")
    } else {
        shiftArrId[index].setValue(projectRate, forKey: "rate")
        shiftArrId[index].setValue(projectRateOver, forKey: "rateOver")
        shiftArrId[index].setValue(projectRateCar, forKey: "rateCar")
        shiftArrId[index].setValue(projectRateDistance, forKey: "rateDistance")
        shiftArrId[index].setValue(shiftDuration, forKey: "shiftDuration")
    }
    
    
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
    }

    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Shift")

    do {
        try managedContext.save()
        shiftArr = try managedContext.fetch(fetchRequest)
        shiftArrWithId(id: selectedProjectRowId)
        print("Shifts in total: ",shiftArr.count)
        print("Shifts in project: ",shiftArrId.count)
    } catch let error as NSError {
        print("Cannot read shift. \(error), \(error.userInfo)")
    }
    
}

func shiftAmount(shift: NSManagedObject) -> Double {
    
    let move: Bool = shift.value(forKey: "move") as! Bool
    let dateBegin: Date = shift.value(forKey: "dateBegin") as! Date
    let dateEnd: Date = shift.value(forKey: "dateEnd") as! Date
    let projectRate: Double = shift.value(forKey: "rate") as! Double
    let projectRateOver: Double = shift.value(forKey: "rateOver") as! Double
    let shiftDuration: Double = shift.value(forKey: "shiftDuration") as! Double
    let currentDinner: Bool = shift.value(forKey: "currentDinner") as? Bool ?? false
    
    if move {
        return (projectRate / 2)
    } else {
        if isMoreThanShift(hours: countHours(begin: dateBegin, end: dateEnd), shift: shiftDuration) {
            if currentDinner {
                return (projectRate) + (Double(ceil(countHours(begin: dateBegin, end: dateEnd) - shiftDuration) + 1) * projectRateOver)
            } else {
                return (projectRate) + (Double(ceil(countHours(begin: dateBegin, end: dateEnd) - shiftDuration)) * projectRateOver)
            }
        } else {
            if currentDinner {
                return projectRate + projectRateOver
            } else {
                return projectRate
            }
        }
    }
}

func countShifts(id: Int) -> Int {
    var k = 0
    
    if shiftArr.count > 0 {
        for i in 0...(shiftArr.count-1) {
            //shift = shiftArr[i]
            if shiftArr[i].value(forKey: "id") as? Int == id {
                k += 1
            }
        }
    } else {
        return 0
    }
    
    return k
}

func shiftArrWithId(id: Int) {
    //var shift: NSManagedObject
    shiftArrId = []
    shiftArrIdIndex = []
    if countShifts(id: id) > 0 {
        for i in 0...(shiftArr.count-1) {
            //shift = shiftArr[i]
            if shiftArr[i].value(forKey: "id") as? Int == id {
                shiftArrId.append(shiftArr[i])
                shiftArrIdIndex.append(i)
            }
        }
    }
}

func getDayInInt(from date: Date) -> Int {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd"
    return Int(formatter.string(from: date))!
}

func getHoursInInt(from date: Date) -> Int {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH"
    return Int(formatter.string(from: date))!
}

func getMinutesInInt(from date: Date) -> Int {
    let formatter = DateFormatter()
    formatter.dateFormat = "mm"
    return Int(formatter.string(from: date))!
}

func countHours(begin dateBegin: Date, end dateEnd: Date) -> Double {
    
    var returnable = 0.0
    if (getDayInInt(from: dateBegin) == getDayInInt(from: dateEnd)) {
        if ( ((getHoursInInt(from: dateBegin) * 60) + getMinutesInInt(from: dateBegin)) < (getHoursInInt(from: dateEnd) * 60) + getMinutesInInt(from: dateEnd) ) {
            
            returnable = Double(getHoursInInt(from: dateEnd) * 60 + getMinutesInInt(from: dateEnd) - getHoursInInt(from: dateBegin) * 60 - getMinutesInInt(from: dateBegin)) / 60
        } else {
            returnable = 0
        }
    } else if (getDayInInt(from: dateBegin) < getDayInInt(from: dateEnd)) {
        returnable = Double((23 - getHoursInInt(from: dateBegin)) * 60 + (60 - getMinutesInInt(from: dateBegin)) + getHoursInInt(from: dateEnd) * 60 + getMinutesInInt(from: dateEnd)) / 60
    } else {
        returnable = 0
    }
    return returnable
}

func isMoreThanShift(hours: Double, shift: Double) -> Bool {
    if (hours > shift) {
        return true
    } else {
        return false
    }
}

func isRateOver(shift: NSManagedObject) -> String {
    
    var hoursWord: String = ""
    let dateBegin: Date = shift.value(forKey: "dateBegin") as! Date
    let dateEnd: Date = shift.value(forKey: "dateEnd") as! Date
    let projectRateOver: Double = shift.value(forKey: "rateOver") as! Double
    let shiftDuration: Double = shift.value(forKey: "shiftDuration") as! Double
    
    if Int(ceil(countHours(begin: dateBegin, end: dateEnd)) -  (shiftDuration)) % 10 == 0 || Int(ceil(countHours(begin: dateBegin, end: dateEnd)) -  (shiftDuration)) > 4 {
        hoursWord = " " + NSLocalizedString("hours", comment: "") + " * "
    } else if Int(ceil(countHours(begin: dateBegin, end: dateEnd)) -  (shiftDuration)) % 10 == 1 {
        hoursWord = " " + NSLocalizedString("hour", comment: "") + " * "
    } else {
        hoursWord = " " + NSLocalizedString("houra", tableName: "Localizable", bundle: Bundle.main, value: "hours", comment: "") + " * "
    }
    
    if isMoreThanShift(hours: countHours(begin: dateBegin, end: dateEnd), shift: shiftDuration) {
        
        return String(Int(ceil(countHours(begin: dateBegin, end: dateEnd)) -  (shiftDuration)) * Int(projectRateOver)) + "\n(" + String(Int(ceil(countHours(begin: dateBegin, end: dateEnd)) -  (shiftDuration))) + NSLocalizedString("h.", comment: "") + " * " + String(Int(projectRateOver)) + ")"
    } else {
       return NSLocalizedString("no", comment: "")
    }


}

func isCurrentDinner(shift: NSManagedObject) -> String {
    let dinner = shift.value(forKey: "currentDinner") as? Bool ?? false
    
    if dinner {
        return String(Int(shift.value(forKey: "rateOver") as! Double))
    } else {
        return NSLocalizedString("no", comment: "")
    }
}

func checkTextFieldIsEmpty(field: UITextField)->Bool {
    if field.text == "" {
        return false
    } else {
        return true
    }
}

func printShift(shift: NSManagedObject) {
    let id = shift.value(forKey: "id") as! Int
    let dateBegin = shift.value(forKey: "dateBegin") as! Date
    let dateEnd = shift.value(forKey: "dateEnd") as! Date
    let rate = shift.value(forKey: "rate") as! Double
    let rateOver = shift.value(forKey: "rateOver") as! Double
    let shiftDuration = shift.value(forKey: "shiftDuration") as! Double
    let currentDinner = shift.value(forKey: "currentDinner") as? Bool
    let move = shift.value(forKey: "move") as? Bool
    
    print("id: ", id)
    print("dateBegin: ", dateBegin)
    print("dateEnd: ", dateEnd)
    print("rate: ", rate)
    print("rateOver: ", rateOver)
    print("shiftDuration: ", shiftDuration)
    print("currentDinner: ", currentDinner as Any)
    print("move: ", move as Any)
}

func printProj(proj: NSManagedObject) {
    let id = proj.value(forKey: "id") as! Int
    let name = proj.value(forKey: "name") as! String
    let rate = proj.value(forKey: "rate") as! Double
    let rateOver = proj.value(forKey: "rateOver") as! Double
    let shiftDuration = proj.value(forKey: "shiftDuration") as! Double
    
    print("id: ", id)
    print("name: ", name)
    print("rate: ", rate)
    print("rateOver: ", rateOver)
    print("shiftDuration: ", shiftDuration)
}
