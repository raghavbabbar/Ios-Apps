//
//  TableViewCell.swift
//  DreamListerApp
//
//  Created by raghav babbar on 29/10/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imagee: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var details: UILabel!

    func update(obj:Item)
    {
        details.text = obj.details!
        price.text = obj.name!
        title.text =  obj.title!
        imagee.image = obj.image! as! UIImage
        
    }
}
