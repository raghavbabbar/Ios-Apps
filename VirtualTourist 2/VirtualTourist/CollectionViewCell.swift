//
//  CollectionViewCell.swift
//  VirtualTourist
//
//  Created by raghav babbar on 15/10/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import UIKit
import CoreData
class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
   /* func  updateCell(with url:String,object:NSManagedObject,fetchresult :  NSFetchedResultsController<NSFetchRequestResult>, d : Bool)
    {
        let obj = object as! Images
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async  {
            let Murl = URL(string:(url))
            let imageadata = try?   Data(contentsOf: Murl!)
               fetchresult.managedObjectContext.perform{
                obj.image = imageadata! as NSData
                try! delegate.stack.saveContext()
            }
            
            DispatchQueue.main.async {
                self.image.image = UIImage(data: obj.image! as Data)
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
            }
            
        }

    
        
    }
    func updateCell(with image:UIImage)
    { DispatchQueue.main.async {
        
        
      self.image.image = image
      self.indicator.stopAnimating()
      self.indicator.isHidden = true
        }
    }
    */
}
