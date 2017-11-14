//
//  TableViewCell.swift
//  On the Map
//
//  Created by raghav babbar on 13/08/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var top: UILabel!
    @IBOutlet weak var bottom: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(person:Person)
    {
        top.text=person.firstName + person.lastName
        bottom.text=person.url
        
    }
    
}
