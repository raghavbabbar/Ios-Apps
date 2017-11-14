//
//  PostViewController.swift
//  On the Map
//
//  Created by raghav babbar on 14/08/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import UIKit
import MapKit
class PostViewController: UIViewController,UITextFieldDelegate {
    
    var update:Bool!
    
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var mapview: MKMapView!
    @IBOutlet weak var down: UIView!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var findOnMapView: UIView!
    @IBOutlet weak var middleLocationView: UIView!
    
    
    let vc=UIActivityIndicatorView()
    var lastString=String()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        linkTextField.delegate=self
        locationTextField.delegate=self
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        self.view.frame.origin.y=0

        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {    if textField == locationTextField
    {
        subscribeToNotification(.UIKeyboardWillShow, selector: #selector(moveUp(notification:)))
        subscribeToNotification(.UIKeyboardWillHide, selector: #selector(moveDown(notification:)))
        

    }
        else
        {  unsubscribeFromAllNotifications()
        }
        
        lastString=textField.text!
        textField.text = ""
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
      
        
        if textField.text == " " || textField.text == ""
        {
            textField.text=lastString
        }
    }
    
    @IBAction func findOnMap(_ sender: Any)   {
        view.endEditing(true)
        if locationTextField.text == "Enter Your Location Here"
        {
            alert(message: "Enter Valid Location",tryAgain: false, res: { })
            return
        }
        
        
        //  setUI(enable: true)
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        vc.activityIndicatorViewStyle = .gray
        vc.hidesWhenStopped=true
        vc.center=self.view.center
        vc.startAnimating()
        self.view.addSubview(vc)
        
        
        let searchrq=MKLocalSearchRequest()
        searchrq.naturalLanguageQuery=locationTextField.text
        
        
        let search=MKLocalSearch(request: searchrq)
        UIApplication.shared.endIgnoringInteractionEvents()
        search.start { (MKLocalSearchResponse, Error) in
            if MKLocalSearchResponse == nil
            {   self.vc.stopAnimating()
                self.alert(message: "No Internet Connection Or Not a Valid Location ",tryAgain: true,res: {
                    self.dismiss(animated: true, completion: nil)
                })
            }
            else
            {
                let coordinate=MKLocalSearchResponse?.boundingRegion.center
                
                let annotation=MKPointAnnotation()
                
                annotation.coordinate=coordinate!
                
                Globaldata.login.lat = (coordinate?.latitude) ?? 0.0
                
                Globaldata.login.long = (coordinate?.longitude) ?? 0.0
                
                annotation.title=self.locationTextField.text
                
                self.vc.stopAnimating()
                self.setUI(enable: true)
                
                self.mapview.addAnnotation(annotation)
                
                let span=MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                
                let region=MKCoordinateRegion(center: coordinate!, span: span)
                
                self.mapview.setRegion(region, animated: true)
                
            }
            
            
        }
        
    }
    
    @IBOutlet weak var dismissPresentView: UIButton!
    
    @IBAction func dismissView(_ sender: Any)
    { dismiss(animated: true, completion: nil)
        
    }
    
    
    func setUI(enable:Bool){
        DispatchQueue.main.async {
            
            
            self.labelView.isHidden=enable
            self.findOnMapView.isHidden=enable
            self.middleLocationView.isHidden=enable
            if enable
            {
                self.down.alpha=0.2
            }
            else
            {
                self.down.alpha = 1
            }
        }
    }
    
    func alert(message:String, tryAgain: Bool  ,res:@escaping (()->()))
    {
        DispatchQueue.main.async {
            
            
            let alertview = UIAlertController(title: "", message: message, preferredStyle: .alert)
            alertview.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {
                action  in
                res()
            }))
            if tryAgain
            {
                alertview.addAction(UIAlertAction(title: " Try again  ", style: .default, handler: { (UIAlertAction) in
                    self.setUI(enable: false)
                }))
            }
            self.present(alertview, animated: true, completion: nil)
        }
    }
    
    @IBAction func storeLocation(_ sender: Any)
    {
        if linkTextField.text == "Enter The Link To Share"
        {
            self.alert(message: "Enter Valid Link",tryAgain: false, res: { })
            return
            
        }
        Globaldata.login.url = linkTextField.text!
        vc.startAnimating()
        if update == nil
        {
            postLocation(httpmethod: "POST",obj: nil,respon: response(e:))
            
        }
        else
        {
            postLocation(httpmethod: "PUT",obj: "/\(Globaldata.login.objId)",respon:response(e:))
            
            
            
        }
    }
    
    
    
    func response(e error:String?)
    {
        
        if error == nil
        {
            self.dismiss(animated: true, completion: nil)
            DispatchQueue.main.async {
                self.vc.stopAnimating()
            }
        }
            
            
        else
        {   DispatchQueue.main.async {
            
            
            
            self.alert(message: error!, tryAgain: true, res: {
                self.dismiss(animated: true, completion: nil)
                
            })
            self.vc.stopAnimating()
            
            }
            
        }
    }
    
    
    
}




extension PostViewController
{


    func moveUp(notification:Notification)
    {
        if self.view.frame.origin.y >= 0
        {
            self.view.frame.origin.y-=self.getHeight(notification: notification)
        }
        
    }
    func moveDown(notification:Notification)
    {
        self.view.frame.origin.y+=self.getHeight(notification: notification)
        
    }
    
    func getHeight( notification: Notification) -> CGFloat {
        let info=(notification as NSNotification).userInfo
        let Size =  info![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return Size.cgRectValue.height
    }

    func subscribeToNotification(_ notification: NSNotification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }
    
    func unsubscribeFromAllNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    

    
}




