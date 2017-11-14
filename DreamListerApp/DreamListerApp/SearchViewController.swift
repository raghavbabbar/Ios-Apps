//
//  SearchViewController.swift
//  DreamListerApp
//
//  Created by raghav babbar on 08/11/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import UIKit
import CoreData

class SearchViewController: UIViewController  ,UITableViewDelegate ,UITableViewDataSource ,NSFetchedResultsControllerDelegate ,UITextFieldDelegate
{   var control: NSFetchedResultsController<Search>! = nil
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var tableview: UITableView!
    var deleted = [IndexPath]()
    
    var updated = [IndexPath]()
    
    var insert = [IndexPath]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fr:NSFetchRequest<Search> = Search.fetchRequest()
        let  nameSort = NSSortDescriptor(key: "name", ascending: true)
        fr.sortDescriptors = [nameSort]
        control = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: (globalObject.stack?.context)!, sectionNameKeyPath: nil, cacheName: nil)
        control.delegate = self
        try! control.performFetch()
        tableview.delegate = self
        tableview.dataSource = self
        control.delegate = self
        try! globalObject.stack?.saveContext()
        searchbtn.layer.cornerRadius = 8
        textfield.delegate = self
        
    }
    
    @IBOutlet weak var searchbtn: UIButton!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func viewWillAppear(_ animated: Bool) {
        // tableview.reloadData()
    }
    @IBAction func searchAction(_ sender: Any) {
        view.endEditing(true)
        if textfield.text == ""
        {
            alert(message: "UPC code missing")
            return;
        }
        DispatchQueue.main.async {
            UIApplication.shared.beginIgnoringInteractionEvents()
            self.indicator.startAnimating()
        }
        
        get_Job_Id(code: textfield.text!) { (done, data) in
            
            if done!
            {
                get_Data_from_Jobid(job_id: data, handler: self.afterGettingData(done:e:jobid:))
            }
                
            else
            { DispatchQueue.main.async {
                UIApplication.shared.endIgnoringInteractionEvents()
                self.indicator.stopAnimating()
                }
                self.alert(message: data!)
                return
            }
        }
        
        
        
    }
    func afterGettingData(done : Bool?, e:String?, jobid:String?)
    {
        if !(done!)
        {
            
            get_Data_from_Jobid(job_id: jobid!, handler: afterGettingData(done:e:jobid:))
            
        }
        else
        {   DispatchQueue.main.async {
            UIApplication.shared.endIgnoringInteractionEvents()
            self.indicator.stopAnimating()
            }
            if e != nil
            {
                self.alert(message: e!)
            }
            else
            {
                let obj = Search(context: (globalObject.stack?.context)!)
                obj.name = Product.name
                obj.price = Product.price
                if Product.image_url != "" {
                    obj.imageUrl = Product.image_url
                }
                obj.shop_name = Product.shop_name
                try! globalObject.stack?.saveContext()
                
                DispatchQueue.main.async {
                    self.textfield.text = ""
                    self.tableview.reloadData()
                    let sb = self.storyboard?.instantiateViewController(withIdentifier: "detail") as! DetailViewController
                    self.present(sb, animated: true, completion: nil)
                }
                
                
                
                
            }
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let c = control.sections
        {
            return  c[section].numberOfObjects
            
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "product") as! ProductTableViewCell
        let  obj = control.object(at: indexPath)
        cell.update(obj:obj)
        DispatchQueue.main.async
            {
                cell.img.image = #imageLiteral(resourceName: "imagePick")
            }
        if  (obj.img == nil) && (obj.imageUrl != nil)  {
            DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async  {
                let Murl = URL(string:(obj.imageUrl)!)
                let imagedata = try? Data(contentsOf: Murl!)
                self.control?.managedObjectContext.perform{
                    obj.img = imagedata! as NSData
                    try! globalObject.stack?.saveContext()
                    DispatchQueue.main.async {
                        cell.img.image = UIImage(data:(obj.img)! as! Data)
                    }
                }
            }
        }
        
        
        if (obj.img != nil)
        {
            DispatchQueue.main.async {
                cell.img.image = UIImage(data:(obj.img)! as! Data)
            }
        }
        
        
        
        return cell
    }
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableview.beginUpdates()
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableview.endUpdates()
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
                
              if   let cell = tableview.cellForRow(at: indexPath) ,let c = cell as? ProductTableViewCell
              {
                let  obj = control.object(at: indexPath)
                c.update(obj: obj)
                }
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
    func alert(message:String )
    {
        DispatchQueue.main.async {
            
            
            let alertview = UIAlertController(title: "", message: message, preferredStyle: .alert)
            alertview.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alertview, animated: true, completion: nil)
        }
    }
}
extension SearchViewController
{
    
    
}
