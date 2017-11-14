//
//  ViewController.swift
//  DreamListerApp
//
//  Created by raghav babbar on 29/10/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import UIKit
import CoreData
let globalObject = UIApplication.shared.delegate as! AppDelegate
class ViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource ,NSFetchedResultsControllerDelegate  {
    
    
    var control: NSFetchedResultsController<Item>! = nil
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let c = control.sections
        {
            return  c[section].numberOfObjects
            
        }
        return 0
    }
    @IBOutlet weak var addItem: UIBarButtonItem!
    @IBAction func addItems(_ sender: Any) {
        performSegue(withIdentifier: "edit", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        let  obj = control.object(at: indexPath)
        cell.update(obj:obj)
        
        return cell
    }
    
     @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
 
    }
    
     
    func setUp()
    {
        self.tableview.delegate = self
        self.tableview.dataSource = self
        fetchData()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.fetchData()
    }
    func fetchData()
    {
        let fetch: NSFetchRequest<Item> = Item.fetchRequest()
        let titleSort = NSSortDescriptor(key: "name", ascending: true)
            fetch.sortDescriptors=[titleSort]
        control = NSFetchedResultsController(fetchRequest: fetch, managedObjectContext: (globalObject.stack?.context)!, sectionNameKeyPath: nil, cacheName: nil)
        control.delegate = self
        
        try! control.performFetch()
        self.tableview.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "edit", sender:indexPath )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender != nil {
            let controll = segue.destination as! EditViewController
            controll.obj = control.object(at: sender as! IndexPath)
        }
    }
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableview.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableview.endUpdates()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch(type) {
            
        case.insert:
            if let indexPath = newIndexPath {
                tableview.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.delete:
            if let indexPath = indexPath {
                tableview.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case.update:
            if let indexPath = indexPath {
                let cell = tableview.cellForRow(at: indexPath) as! TableViewCell
                let  obj = control.object(at: indexPath)
                cell.update(obj: obj)
                
            }
            break
        case.move:
            if let indexPath = indexPath {
                tableview.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableview.insertRows(at: [indexPath], with: .fade)
            }
            break
            
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sc = control
        {
            return (sc.sections?.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            control.managedObjectContext.delete(control.object(at: indexPath))
            try! globalObject.stack?.saveContext()
            
        }
    }
    
}
extension ViewController
{
    
    
}
extension ViewController
{
    
    
    
}
