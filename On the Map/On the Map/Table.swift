//
//  Table.swift
//  On the Map
//
//  Created by raghav babbar on 18/03/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import UIKit

class Table:Base,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate=self
        table.dataSource=self
        
        notify()
        getStudentData(responsee: {
            error in
            if error != nil
            {
                
                self.alert(message: error!)
            }
            
            
        })
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return Globaldata.personData.count
    }
    @IBAction func get_dataa(_ sender: Any)
    {
        super.get_data(response: {
            error in
            if error != nil
            {
                self.alert(message: error!)
                
            }
            
            
        })
        
    }
    @IBAction func addpin(_ sender: Any)
    {
        super.goToPostVc()
    }
    @IBAction func logout(_ sender: Any)
    {
        super.logout()
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.configureCell(person: Globaldata.personData[indexPath.row])
        
        
        return cell
    }
    func reload()
    {
        DispatchQueue.main.async {
            
            
            self.table.reloadData()
        }
    }
    func notify()
    {
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name(rawValue: Constanskey.pinAdded) , object: nil)
    }
    
    func alert(message:String )
    {
        DispatchQueue.main.async {
            
            
            let alertview = UIAlertController(title: "", message: message, preferredStyle: .alert)
            alertview.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {
                action in
                
            }))
            self.present(alertview, animated: true, completion: nil)
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let url = Globaldata.personData[indexPath.row].link
        if let url = NSURL(string:  url) {
            if UIApplication.shared.canOpenURL(url as URL) {
                UIApplication.shared.open(url as URL)
            } else {
                alert(message: "Can Not Open Url")
            }
            
            
            
        }
        
    }
}

extension Table
{
    
    
    
    
    
    
    
}
