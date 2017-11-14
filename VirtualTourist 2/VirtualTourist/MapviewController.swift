//
//  MapviewController.swift
//  VirtualTourist
//
//  Created by raghav babbar on 15/10/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import UIKit
import MapKit
import CoreData
let delegate = UIApplication.shared.delegate as! AppDelegate
class MapviewController: UIViewController , MKMapViewDelegate ,UIGestureRecognizerDelegate{

    @IBOutlet weak var map : MKMapView!
    let stack = delegate.stack
    
    var fetchedResultsController : NSFetchedResultsController<NSFetchRequestResult>?
    
    
    

    let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Pin")
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        self.loadData()
    }
    
    func addPin(_ gesture : UILongPressGestureRecognizer)
    {  if gesture.state == UIGestureRecognizerState.began
    {
        let location = gesture.location(in: map)
        let coords = map.convert(location,toCoordinateFrom: map)
        let annoation = MKPointAnnotation()
        annoation.coordinate=coords
        let _ = Pin(latitude: coords.latitude, longitude: coords.longitude, context: (fetchedResultsController?.managedObjectContext)!)
        try! stack.saveContext()
        loadData()
        
        
        
        }
        
    }

    
    public func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {   var pointt : NSManagedObject!
        print("calling ")
        let pp1 = NSPredicate(format: "lat = %@", argumentArray: [(view.annotation?.coordinate.latitude)!])
        let pp2 = NSPredicate(format: "long = %@", argumentArray:
            [(view.annotation?.coordinate.longitude)!])
        let frr =  NSFetchRequest<NSFetchRequestResult>(entityName: "Pin")
        let andPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [pp1, pp2])
        frr.predicate = andPredicate
        frr.sortDescriptors  = [NSSortDescriptor(key: "lat", ascending: true)]
        fetchedResultsController =  NSFetchedResultsController(fetchRequest: frr, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
        afterFetch(fetchedResultsController: fetchedResultsController, completion: {
            
            let obj = fetchedResultsController?.fetchedObjects as! [NSManagedObject]
            pointt=obj[0]
            
            
        })
        
        map.deselectAnnotation(view.annotation, animated: false)
        print("calling")
        performSegue(withIdentifier: "ss", sender: pointt  )
        
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let des  = segue.destination as! ViewController
       // print("11111")
        des.point = sender as! Pin
       // print("2222")
    }
   
}

extension MapviewController
{  func loadData()
{
    fr.sortDescriptors = [NSSortDescriptor(key: "lat", ascending: false),
                          NSSortDescriptor(key: "long", ascending: true)]
    fetchedResultsController =  NSFetchedResultsController(fetchRequest: fr, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
    
    afterFetch(fetchedResultsController: fetchedResultsController, completion: {
        
        let p:[Pin] = fetchedResultsController?.fetchedObjects as! [Pin]
        
        DispatchQueue.global(qos: .userInitiated).async {
            var anno=[MKPointAnnotation]()
            for a in p
            { let annotion = MKPointAnnotation()
               // annotion.title = a.title!
                annotion.coordinate = CLLocationCoordinate2D(latitude: a.lat, longitude: a.long)
                anno.append(annotion)
                
            }
            DispatchQueue.main.async {
                self.map.addAnnotations(anno)
            }
            
            
            
        }
        
        
        
    })
    
    
    }
    

    
    func setUp()
    {
        map.delegate = self
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(addPin(_:)))
        gesture.delegate = self  
        gesture.minimumPressDuration = 0.8
        gesture.allowableMovement = 1
        map.addGestureRecognizer(gesture)

    }
    
    func afterFetch(fetchedResultsController : NSFetchedResultsController<NSFetchRequestResult>? , completion:()->())
    {
        fetchedResultsController?.delegate = self as? NSFetchedResultsControllerDelegate
        executeSearch()
        completion()
        
        
    }
    func executeSearch() {
        if let fc = fetchedResultsController {
            do {
                try fc.performFetch()
            } catch let e as NSError {
                print("Error while trying to perform a search: \n\(e)\n\(String(describing: fetchedResultsController))")
            }
        }
    }

    
}
