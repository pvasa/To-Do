//
//  ToDoItem.swift
//  To-Do
//
//  Created by Priyank Vasa on 2017-02-20.
//  Copyright © 2017 Ryan. All rights reserved.
//

import Foundation
import RealmSwift

class ToDoItem: Object {
    
    dynamic var index: Int = 0 // Item index
    dynamic var title: String = "Title" // Item title
    dynamic var notes: String = "Notes" // Item notes
    dynamic var done: Bool = false // Item done or not
    dynamic var date: Date = Date() // Item date
    
}
