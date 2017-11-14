//
//  Base.swift
//  On the Map
//
//  Created by raghav babbar on 18/03/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import UIKit

class Base: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func get_data(response:@escaping(_ error:String?)->())
    {
        getStudentData(responsee:{
        
        error in
        response(error)
            
        }
        
        )
        
        
        
    }
    func goToPostVc()
    {
        if Globaldata.login.objId != ""
        {
            DispatchQueue.main.async {
                
                self.alert(message: " Overwrite Location ? ", cHandler: {
                    
                    let control = self.storyboard?.instantiateViewController(withIdentifier: "post") as! PostViewController
                    control.update = true
                    self.present(control, animated: true, completion: nil)
                    
                })
            }
        }
        else
        {
            
            gotoPost()
            
        }
    }
    
    private func gotoPost()
    {
        let control = self.storyboard?.instantiateViewController(withIdentifier: "post") as! PostViewController
        self.present(control, animated: true, completion: nil)
        
    }
    
    
    
    func alert(message:String,cHandler:@escaping ()->()){
        DispatchQueue.main.async {
            
            
            let alertview = UIAlertController(title: "", message: message, preferredStyle: .alert)
            alertview.addAction(UIAlertAction(title: "Add New ", style: .default, handler: {
                a in
                self.gotoPost()
            }))
            alertview.addAction(UIAlertAction(title: "Overwrite", style: .default, handler:{
                a in
                cHandler()
            }))
            
            self.present(alertview, animated: true, completion: nil)
        }
        
        
    }
    
    func logout()
    {   self.view.alpha = 0.7
        UIApplication.shared.beginIgnoringInteractionEvents()
        logoutCall { error in
            if error == nil
            {  let control = self.storyboard?.instantiateViewController(withIdentifier: "login") as! LoginViewController
                self.present(control, animated: true, completion: {
                    self.view.alpha = 1
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                })
                
                
            }
            else
            {
                let alertview = UIAlertController(title: "", message: error!, preferredStyle: .alert)
                alertview.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {
                    action in
                    
                    self.view.alpha = 1
                }))
                DispatchQueue.main.async {
                    UIApplication.shared.endIgnoringInteractionEvents()
                    self.present(alertview, animated: true, completion: nil)
                }
            }
        }
        
        
        
    }
}


