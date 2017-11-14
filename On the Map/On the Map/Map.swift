//
//  Map.swift
//  On the Map
//
//  Created by raghav babbar on 18/03/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import UIKit
import MapKit

class Map:Base,MKMapViewDelegate
{
    @IBOutlet weak var mapview: MKMapView!
    var point=[MKPointAnnotation]()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        mapview.delegate=self
        notify()
        getStudentData(responsee: {
            error in
            if error != nil
            {
                
                self.alert(message: error!)
            }
            
            
        })
    }
    
    
    
    func addPins()
    {
        
        if !Globaldata.annoiation.isEmpty
        {
            DispatchQueue.main.async {
                self.point = Globaldata.annoiation
                self.mapview.removeAnnotations(self.mapview.annotations)
                self.mapview.addAnnotations(self.point)
            }
        }
        
        
    }
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func notify()
    {
        
        NotificationCenter.default.addObserver(self, selector: #selector(addPins), name: NSNotification.Name(rawValue: Constanskey.pinAdded) , object: nil)
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        
        if control == view.rightCalloutAccessoryView {
            let url:NSString = ( view.annotation?.subtitle)!! as NSString
            let urlStr : NSString = url.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
            
            if let URL = NSURL(string:  urlStr as String)
            {
                if UIApplication.shared.canOpenURL(URL as URL) {
                    UIApplication.shared.open(URL as URL)
                }
                else {
                    alert(message:"Can not Oen Url")
                }
            }
            
            
        }
        
        
        
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
    
    @IBAction func refresh(_ sender: Any) {
        super.get_data(response: {
            error in
            if error != nil
            {
                self.alert(message: error!)
                
            }
            
            
        })
    }
    @IBAction func addpins(_ sender: Any)
    {
        super.goToPostVc()
    }
    @IBAction func logout(_ sender: Any) {
        super.logout()
    }
}
extension Map
{
    
    
    
    
}
