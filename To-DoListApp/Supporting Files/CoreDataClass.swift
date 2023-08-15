//
//  CoreDataClass.swift
//  To-DoListApp
//
//  Created by Amaan Gillani on 14/08/2023.
//

import UIKit
import CoreData

class CoreDataClass : NSObject{
    static var instance: CoreDataClass = {
        let instance = CoreDataClass()
        return instance
    }()
    private var items: [TaskModelItem] = []
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate

    func fetch() -> [TaskModelItem] {
        let managedObjectContext = self.appDelegate?.persistentContainer.viewContext
        let fetchRequest = TaskModelItem.fetchRequest()
        do {
            items = try managedObjectContext!.fetch(fetchRequest)
            return items
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    /// [If you wanna add a tast in list, you must use this method.]
    func addTaskFunc(nameText : String) {
        if nameText != "" {
            let entityName = "TasksList"
            let managedObjectContext = appDelegate?.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(
                forEntityName: entityName,
                in: managedObjectContext!
            )
            let taskName = TaskModelItem(
                entity: entity!,
                insertInto: managedObjectContext
            )
            taskName.setValue(nameText, forKey: "name")
            onDatabaseSave(db: managedObjectContext)
        } else {
          //  error
        }

    }
    
    /// [Task is deleted from list by this method.]
    func deleteTask(indexPath: IndexPath) {
        let managedObjectContext = self.appDelegate?.persistentContainer.viewContext
        managedObjectContext?.delete(self.items[indexPath.row])
        self.onDatabaseSave(db: managedObjectContext)
    }
    
    /// [Task is edited from list by this method.]
    func editTask(indexPath: IndexPath, taskName: String) {
        let item = self.items[indexPath.row]
        var nameText = item.name
        nameText = taskName
        let managedObjectContext = self.appDelegate?.persistentContainer.viewContext
        if nameText != "" {
            item.name = nameText!
            item.setValue(nameText, forKey: "name")
        }
        self.onDatabaseSave(db: managedObjectContext)
    }
    /// [The changes are saved on database by this method.]
    func onDatabaseSave(db: NSManagedObjectContext?) {
        do {
            try db?.save()
     //       self.fetch()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
