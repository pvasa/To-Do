//
//  ToDoItem.swift
//  To-Do
//
//  Created by Ryan on 2017-01-31.
//  Copyright © 2017 Ryan. All rights reserved.
//

import UIKit

class ToDoItem: NSObject {
    
    var title: String = "Title"
    var notes: String = "Notes"
    var done: Bool = false
    
    init(_ title: String, _ notes: String?) {
        self.title = title
        self.notes = notes ?? ""
    }

}
