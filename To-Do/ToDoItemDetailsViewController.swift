//
//  ToDoItemDetailsViewController.swift
//  To-Do
//
//  Created by Ryan on 2017-01-31. - 300872404
//  Copyright © 2017 Ryan. All rights reserved.
//

import UIKit

protocol ToDoItemDelegate {
    func addItem(_ todoItem: ToDoItem)
    func updateItem(at: Int, with: ToDoItem)
    func deleteItem(at: Int)
}

class ToDoItemDetailsViewController: UIViewController {

    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var notesText: UITextField!
    @IBOutlet weak var date: UIDatePicker!
    
    var delegate: ToDoItemDelegate?
    var todoItem: ToDoItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        date.datePickerMode = UIDatePickerMode.date // set date picker mode to date only
        
        if todoItem != nil { // Set todo details coming from cell click
            self.title = "Update item"
            titleText.text = todoItem?.title
            notesText.text = todoItem?.notes
            date.date = (todoItem?.date)!
        } else { // Coming from add button
            self.title = "Add item"
        }
    }

    // Save button
    @IBAction func saveItem(_ sender: UIBarButtonItem) {
        if ((titleText.text!.characters.count) > 0) {
            if let delegate = delegate {
                let newItem: ToDoItem = ToDoItem()
                newItem.title = titleText.text!
                newItem.notes = notesText.text!
                newItem.date = date.date
                if todoItem != nil {
                    delegate.updateItem(at: todoItem!.index, with: newItem)
                } else {
                    delegate.addItem(newItem)
                }
                _ = navigationController?.popViewController(animated: true)
            }
        }
    }
    
    // Delete button
    @IBAction func deleteItem(_ sender: UIBarButtonItem) {
        if todoItem != nil {
            delegate!.deleteItem(at: todoItem!.index)
            _ = navigationController?.popViewController(animated: true)
        }
    }
}
