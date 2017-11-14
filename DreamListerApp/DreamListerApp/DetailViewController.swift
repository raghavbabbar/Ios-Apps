//
//  DetailViewController.swift
//  DreamListerApp
//
//  Created by raghav babbar on 08/11/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var shop_name: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     self.name.text = Product.name
     self.shop_name.text = Product.shop_name
     self.price.text = "$" + Product.price
     Product.refresh()
    }
   
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
