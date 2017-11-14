//
//  BaseViewController.swift
//  VirtualTourist
//
//  Created by raghav babbar on 15/10/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import UIKit
import CoreData
//let delegate = UIApplication.shared.delegate as! AppDelegate
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    var fetchedResultsController : NSFetchedResultsController<NSFetchRequestResult>?
    
    
    
    
    
    func afterFetch(fetchedResultsController : NSFetchedResultsController<NSFetchRequestResult>? , completion:()->())
    {
        fetchedResultsController?.delegate = self as? NSFetchedResultsControllerDelegate
        executeSearch()
        completion()
        
        
    }
}
extension  BaseViewController {
    
    func executeSearch() {
        if let fc = fetchedResultsController {
            do {
                try fc.performFetch()
            } catch let e as NSError {
                print("Error while trying to perform a search: \n\(e)\n\(fetchedResultsController)")
            }
        }
    }
}


