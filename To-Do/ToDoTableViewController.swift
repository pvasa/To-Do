//
//  ToDoTableViewController.swift
//  To-Do
//
//  Created by Ryan on 2017-01-31. - 300872404
//  Copyright © 2017 Ryan. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoTableViewController: UITableViewController, ToDoItemDelegate {

    var realm = try! Realm() // Load realm object
    
    var todoItems:List<ToDoItem> {
        get {
            return List(realm.objects(ToDoItem.self)) // return data from realm
        }
        set(_todoItems) {
            self.todoItems = _todoItems
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem // Edit button
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! ToDoTableViewCell

        // Set cell text and properties
        
        cell.toDoCellTitle.text = todoItems[indexPath.row].title
        cell.toDoCellTitle.alpha = todoItems[indexPath.row].done ? 0.4 : 1
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        let timeString = dateFormatter.string(from: todoItems[indexPath.row].date as Date)
        cell.toDoCellDate.text = String(timeString)
        cell.toDoCellDate.alpha = todoItems[indexPath.row].done ? 0.4 : 1

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row) // Move item
    }
    
    // Custom actions for swipe gesture
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let todoItem = todoItems[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath) as! ToDoTableViewCell
        
        // Done/Undone action for an item
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
        
        // Delete action for an item
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            self.deleteItem(at: indexPath.row)
        }
        
        return [toggleDoneAction, deleteAction]
    }
    
    // Pass todo item to details page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueId = segue.identifier else { return }
        
        switch segueId {
        case "detailSegue":
            let destinationVC = segue.destination as! ToDoItemDetailsViewController
            destinationVC.delegate = self
            if (tableView.indexPathForSelectedRow?.row != nil) {
                destinationVC.todoItem = todoItems[(tableView.indexPathForSelectedRow?.row)!]
            }
            break
        default:
            break
        }
    }
    
    // Go to details page on cell click
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: Any?.self)
    }
    
    // Add item to db
    func addItem(_ todoItem: ToDoItem) {
        todoItem.index = todoItems.count
        try! realm.write {
            realm.add(todoItem)
            self.tableView.insertRows(at: [IndexPath(row: todoItem.index, section: 0)], with: .automatic)
        }
    }
    
    // Delete item from db
    func deleteItem(at: Int) {
        try! realm.write {
            realm.delete(todoItems[at])
            self.tableView.deleteRows(at: [IndexPath(item: at, section: 0)], with: .automatic)
        }
    }
    
    // Update item in db
    func updateItem(at: Int, with: ToDoItem) {
        self.deleteItem(at: at)
        self.addItem(with)
    }
    
    // Move item position
    func moveItem(from: Int, to: Int) {
        try! realm.write {
            todoItems.move(from: from, to: to)
            //tableView.reloadData()
        }
    }
}
