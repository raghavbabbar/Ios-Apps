//
//  ProductTableViewCell.swift
//  DreamListerApp
//
//  Created by raghav babbar on 08/11/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell  {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var shopname: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func update(obj:Search)
    {  DispatchQueue.main.async {
        
        
        self.price.text = "$" + obj.price!
        self.shopname.text = obj.shop_name!
        }
    }
}
