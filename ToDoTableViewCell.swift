//
//  ToDoTableViewCell.swift
//  To-Do
//
//  Created by Ryan on 2017-01-31.
//  Copyright © 2017 Ryan. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    @IBOutlet weak var todoCellTitle: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
