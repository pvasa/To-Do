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
    
    dynamic var title: String = "Title"
    dynamic var notes: String = "Notes"
    dynamic var done: Bool = false
    dynamic var date: Date = Date()
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
