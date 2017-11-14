//
//  CoreDataviewController.swift
//  VirtualTourist
//
//  Created by raghav babbar on 18/10/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class CoreDataviewController: UIViewController, UICollectionViewDelegate {
    @IBOutlet weak var collection: UICollectionView!
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    var deleted = [IndexPath]()
    
    var updated = [IndexPath]()

    var insert = [IndexPath]()
    
    
    var fetchedResultsController : NSFetchedResultsController<Images>?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func executeSearch(){
        if let fc = fetchedResultsController{
            do{
                try fc.performFetch()
            }catch {
                print("Error!")
            }
        }
    }
    func numberOfSectionsInCollectionView(_ collectionView: UICollectionView) -> Int {
        if let count = self.fetchedResultsController{
            return (count.sections?.count)!
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if let sco = self.fetchedResultsController!.sections {
        return sco[section].numberOfObjects
            
            
        }
        
        
        return 0
        
    }
    
        @objc(collectionView:didSelectItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        if let fc = self.fetchedResultsController {
            fc.managedObjectContext.delete((fetchedResultsController?.object(at: indexPath))! as NSManagedObject)
            try! self.delegate.stack.saveContext()
            DispatchQueue.main.async {
                
            
                self.collection.reloadData() }
            
        }
    }

}
extension CoreDataviewController: NSFetchedResultsControllerDelegate{
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
    {
        //collection.beginUpdates()
        self.insert  = [IndexPath]()
        self.deleted = [IndexPath]()
        self.updated = [IndexPath]()

    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
          //   self.collection.deleteItems(at: [indexPath!])
            self.deleted.append(indexPath!)
            break
        case .insert:
            //self.collection.insertItems(at: [newIndexPath!])
            self.insert.append(newIndexPath!)
            break
        case .update:
           // self.collection.reloadItems(at: [indexPath!])
            self.updated.append(indexPath!)
            break
        default:
            return
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
     // collection.endUpdates()
        self.collection.performBatchUpdates({ () -> Void in
            for i in self.updated {
                self.collection.reloadItems(at: [i])
            }
            for i in self.insert {
                self.collection.insertItems(at: [i])
            }
            for i in self.deleted {
                self.collection.deleteItems(at: [i])
            }
            
        }, completion: nil)

        
    }
}

