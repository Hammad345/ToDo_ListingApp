//
//  ViewController.swift
//  To-DoListApp
//
//  Created by Amaan Gillani on 13/08/2023.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    private var items: [TaskModelItem] = []
    private let stringConstants = StringContants.instance
    private let coreDataInstance = CoreDataClass.instance

    @IBOutlet weak var tableView: UITableView!
    var selectedRows:[IndexPath] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        view.setGradientBackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetch()
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        let dashboard = self.storyboard?.instantiateViewController(withIdentifier: "AddEditViewController") as! AddEditViewController
        self.navigationController?.pushViewController(dashboard, animated: true)
    }

    /// [The data are fetched on database by this method]
    private func fetch() {
        items = coreDataInstance.fetch()
        tableView.reloadData()
    }
    /// [Task is edited from list by this method.]
    func editTask(indexPath: IndexPath) {
        let AddEditVC = self.storyboard?.instantiateViewController(withIdentifier: "AddEditViewController") as! AddEditViewController
        AddEditVC.taskToEditIndextPath = indexPath
        self.navigationController?.pushViewController(AddEditVC, animated: true)
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell:CustomTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as! CustomTableViewCell

        cell.taskNameLbl.text = "\(items[indexPath.row].name ?? "NULL_NAME")"
        
        if selectedRows.contains(indexPath)
        {
            cell.checkBox.setImage(UIImage(named:"check"), for: .normal)
        }
        else
        {
            cell.checkBox.setImage(UIImage(named:"uncheck"), for: .normal)
        }
        cell.checkBox.tag = indexPath.row
        cell.checkBox.addTarget(self, action: #selector(checkBoxSelection(_:)), for: .touchUpInside)        
        return cell
    }

    func tableView(_ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: stringConstants.delete)
        {
            _, _, _ in
            self.coreDataInstance.deleteTask(indexPath: indexPath)
            self.fetch()
        }
        deleteAction.backgroundColor = .systemRed

        let editAction = UIContextualAction(style: .normal, title: stringConstants.edit) {
            _, _, _ in
            self.editTask(indexPath: indexPath)
        }
        editAction.backgroundColor = .systemOrange
        let config = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return config
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell else {
            return
        }
        if self.selectedRows.contains(indexPath) {
            self.selectedRows.remove(at: self.selectedRows.firstIndex(of: indexPath)!)
            cell.checkBox.setImage(UIImage(named:"uncheck"), for: .normal)
        } else {
            self.selectedRows.append(indexPath)
            cell.checkBox.setImage(UIImage(named:"check"), for: .normal)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50 //or whatever you need
    }
    
    @objc func checkBoxSelection(_ sender:UIButton)
     {
         let selectedIndexPath = IndexPath(row: sender.tag, section: 0)
         if self.selectedRows.contains(selectedIndexPath)
         {
             self.selectedRows.remove(at: self.selectedRows.firstIndex(of: selectedIndexPath)!)
         }
         else
         {
             self.selectedRows.append(selectedIndexPath)
         }
         self.tableView.reloadData()
     }
}



