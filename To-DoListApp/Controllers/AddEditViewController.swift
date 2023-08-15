//
//  AddEditViewController.swift
//  To-DoListApp
//
//  Created by Amaan Gillani on 13/08/2023.
//

import UIKit
import CoreData

class AddEditViewController: UIViewController {
    private var items: [TaskModelItem] = []
    private let coreDataInstance = CoreDataClass.instance
    private let stringConstants = StringContants.instance
    var alertController = UIAlertController()
    var taskToEditIndextPath = IndexPath()

    @IBOutlet weak var nameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground()
        nameTextField.placeholder = "Please add task"
        fetch()
        if taskToEditIndextPath != [] {
            let item = self.items[taskToEditIndextPath.row]
            let nameText = item.name
            nameTextField.text = nameText
        }
    }
    
    @IBAction private func saveTaskBtnAction(_ sender: Any) {
        if taskToEditIndextPath != [] {
            editTask(indexPath: taskToEditIndextPath)
        }else {
            addTaskFunc()
        }
    }

    /// [If you wanna add a tast in list, you must use this method.]
    private func addTaskFunc() {
        let nameText = nameTextField.text
        if nameText != "" {
            coreDataInstance.addTaskFunc(nameText: nameText!)
            presentAlert(
                title: stringConstants.addButton,
                message: stringConstants.addTaskSucces,
                cancelButtonTitle: stringConstants.okButton
            )
        }else {
            // enter tast
        }
    }

    /// [Task is edited from list by this method.]
    func editTask(indexPath: IndexPath) {
        let nameText = nameTextField.text
        if nameText != "" {
            coreDataInstance.editTask(indexPath: indexPath, taskName: nameText!)
            presentAlert(
                title: stringConstants.edit,
                message: stringConstants.editSuccesAlertTitle,
                cancelButtonTitle: stringConstants.okButton
            )
        }else {
            // no text in textfield
        }
    }
    
    /// [The data are fetched on database by this method]
    private func fetch() {
        items = coreDataInstance.fetch()
    }
}
