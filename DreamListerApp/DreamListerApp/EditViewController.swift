//
//  EditViewController.swift
//  DreamListerApp
//
//  Created by raghav babbar on 31/10/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import UIKit
import CoreData
class EditViewController: UIViewController ,UITextFieldDelegate ,UIImagePickerControllerDelegate ,UINavigationControllerDelegate,UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var upc: UITextField!
    @IBOutlet weak var pickController: UIPickerView!
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var titlee: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var details: UITextField!
    var array=[Store]()
    let opened = "openBefore"
    var  obj:Item! = nil
    let imageController = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        add.layer.cornerRadius = 7
        self.setDelegates()
        if UserDefaults.standard.object(forKey: opened) == nil
        {
            UserDefaults.standard.set(true, forKey: opened)
            dummyData()
        }
        if obj != nil
        {
            setData()
        }
        getStore()
    }
    func setDelegates()
    {   upc.delegate = self
        titlee.delegate = self
        price.delegate = self
        details.delegate = self
        pickController.delegate = self
        pickController.dataSource = self
        imageController.delegate = self
        upc.keyboardType = .numberPad 
    }
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool
    { textField.resignFirstResponder()
        return true
        
    }
    
    
    @IBAction func addImage(_ sender: Any) {
        present(imageController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            imageview.image = img
        }
        
        imageController.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveItem(_ sender: Any) {
        let item:Item!
        if obj == nil {
            item = Item(context: ( globalObject.stack?.context )!)
        }
        else
        {
            item = obj
        }
        item.details = details.text ?? ""
        item.title = titlee.text ?? ""
        if (price.text?.characters.contains("$"))! {
        item.name = price.text ?? ""
        }
        else
        {
            item.name = "$" + (price.text ?? "")
        }
        item.image = imageview.image ?? #imageLiteral(resourceName: "imagePick")
        item.toStore = array[pickController.selectedRow(inComponent: 0)]
        try! globalObject.stack?.saveContext()
        _ = navigationController?.popViewController(animated: true)
    }
    
    func dummyData()
    {
        let a = Store(context: (globalObject.stack?.context)!)
        a.name="Amazon"
        
        let aaa = Store(context: (globalObject.stack?.context)!)
        aaa.name="FlipKart"
        
        let aa = Store(context: (globalObject.stack?.context)!)
        aa.name="AlIbaba"
        
        let p = Store(context: (globalObject.stack?.context)!)
        p.name="SnapDeal"
        
        let q = Store(context: (globalObject.stack?.context)!)
        q.name="Big18"
        
        let pp = Store(context: (globalObject.stack?.context)!)
        pp.name="Ebay"
        
        let pr = Store(context: (globalObject.stack?.context)!)
        pr.name="Myntra"
        
        
        try!  globalObject.stack?.saveContext()
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return array[row].name!
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return array.count
    }
    func getStore()
    {
        let fetch: NSFetchRequest<Store>  = Store.fetchRequest()
        let titleSort = NSSortDescriptor(key: "name", ascending: true)
        fetch.sortDescriptors = [titleSort]
        let fetchResult = NSFetchedResultsController(fetchRequest: fetch, managedObjectContext: (globalObject.stack?.context)!, sectionNameKeyPath: nil, cacheName: nil)
        
        try! fetchResult.performFetch()
        self.array = fetchResult.fetchedObjects!
        pickController.reloadAllComponents()
    }
    func setData ()
    {
        self.details.text = obj.details ?? ""
        self.price.text = obj.name ?? ""
        self.titlee.text = obj.title ?? ""
        var i = 0
        while i < array.count
        {
            if self.obj.toStore?.name == array[i].name
            {
                self.pickController.selectRow(i, inComponent: 0, animated: true)
                break
            }
            i += 1
        }
        
    }
    func disableUI(disable : Bool )
    {
        if disable
        {DispatchQueue.main.async {
          
            UIApplication.shared.beginIgnoringInteractionEvents()
            }
        }
        else
        {
            DispatchQueue.main.async {
                
                UIApplication.shared.endIgnoringInteractionEvents()
                
            }
            
        }
        
    }
    
    func alert(message:String )
    {
        DispatchQueue.main.async {
            
            
            let alertview = UIAlertController(title: "", message: message, preferredStyle: .alert)
            alertview.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {
                action in
                DispatchQueue.main.async {
                    self.disableUI(disable: false)
                    
                }
            }))
            self.present(alertview, animated: true, completion: nil)
        }
    }
    @IBAction func priceCheck(_ sender: Any) {
        view.endEditing(true)
        Globaldata.login.job_id = ""
        
        if upc.text == ""
        {
            
            alert(message:"Enter the UPC Code")
            return
        }
        else
        {
            disableUI(disable: true)
            
            DispatchQueue.main.async {
                self.price.text = ""
                self.indicator.startAnimating()
            }
            
            
           
          //  getPrice(code: upc.text!, handler:handler(e:))
            
            
            get_Job_Id(code: upc.text!) { (done, data) in
                
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
        
    }
    @IBOutlet weak var checkPrice: UIButton!
    
     func handler(e er:String?)
     {  disableUI(disable: false)
        DispatchQueue.main.async
        {
        self.indicator.stopAnimating()
        }
        if er != nil || Globaldata.login.job_id == ""
        {
            self.alert(message: er!)
            
        }
        else
        {
            get_Job_Id(code: upc.text!) { (done, data) in
            self.disableUI(disable: false)
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
        
        
    }
        
        
        
        
    }

extension EditViewController
{
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
               
                try! globalObject.stack?.saveContext()
                
                DispatchQueue.main.async {
                    self.upc.text = ""
                    self.price.text = Product.price
                    let sb = self.storyboard?.instantiateViewController(withIdentifier: "detail") as! DetailViewController
                    self.present(sb, animated: true, completion: nil)
                }
                
                
                
                
            }
            
        }
    }
    
    
    
}
