//
//  ToDoTableViewController.swift
//  To-Do
//
//  Created by Ryan on 2017-01-31.
//  Copyright © 2017 Ryan. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoTableViewController: UITableViewController, ToDoItemDelegate {

    let realm = try! Realm()
    
    var todoItems:List<ToDoItem> {
        get {
            return List(realm.objects(ToDoItem.self))
        }
        set(_todoItems) {
            self.todoItems = _todoItems
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! ToDoTableViewCell

        cell.toDoCellTitle.text = todoItems[indexPath.row].title
        cell.toDoCellTitle.alpha = todoItems[indexPath.row].done ? 0.4 : 1

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        try! realm.write {
            todoItems.move(from: sourceIndexPath.row, to: destinationIndexPath.row)
        }
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let todoItem = todoItems[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath) as! ToDoTableViewCell
        
        let toggleDoneAction = UITableViewRowAction(style: .normal, title: "Done") { (action, indexPath) in
            try! self.realm.write {
                todoItem.done = !todoItem.done
            }
            tableView.reloadRows(at: [indexPath], with: .right)
        }
        
        if (todoItem.done) {
            toggleDoneAction.title = "Undone"
            cell.toDoCellTitle.alpha = 0.4
        } else {
            toggleDoneAction.title = "Done"
            cell.toDoCellTitle.alpha = 1
        }
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            try! self.realm.write {
                self.realm.delete(self.todoItems[indexPath.row])
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
        
        return [toggleDoneAction, deleteAction]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueId = segue.identifier else { return }
        
        switch segueId {
        case "detailSegue":
            (segue.destination as! ToDoItemDetailsViewController).delegate = self
            break
        default:
            break
        }
    }
    
    func addItem(_ todoItem: ToDoItem) {
        try! realm.write {
            realm.add(todoItem)
            self.tableView.insertRows(at: [IndexPath(row: todoItems.count - 1, section: 0)], with: .automatic)
        }
    }
    
    /*
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Done") { action in
            //handle delete
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { action in
            //handle edit
        }
        
        return [deleteAction, editAction]
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
