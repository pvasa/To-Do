//
//  ToDoItemDetailsViewController.swift
//  To-Do
//
//  Created by Ryan on 2017-01-31.
//  Copyright © 2017 Ryan. All rights reserved.
//

import UIKit

protocol ToDoItemDelegate {
    func addItem(_ todoItem: ToDoItem)
}

class ToDoItemDetailsViewController: UIViewController {

    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var notesText: UITextField!
    var delegate: ToDoItemDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveItem(_ sender: UIBarButtonItem) {
        if ((titleText.text!.characters.count) > 0) {
            if let delegate = delegate {
                let newItem = ToDoItem()
                newItem.title = titleText.text!
                newItem.notes = notesText.text!
                delegate.addItem(newItem)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
