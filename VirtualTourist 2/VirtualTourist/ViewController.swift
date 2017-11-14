//
//  ViewController.swift
//  VirtualTourist
//
//  Created by raghav babbar on 15/10/17.
//  Copyright © 2017 raghav babbar. All rights reserved.


import UIKit
import MapKit
import CoreData


class ViewController: CoreDataviewController , MKMapViewDelegate ,UICollectionViewDataSource  {
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var btn: UIButton!
    
    var annotations = [MKPointAnnotation]()
    var point : Pin!
    
    @IBAction func btnAction(_ sender: Any) {
        btn.isEnabled = false
        let photo = (self.point.image!) as NSSet
        for obj in photo{
            self.fetchedResultsController?.managedObjectContext.delete(obj as! NSManagedObject)
        }
        getUrls(){ (success, error) in
            DispatchQueue.main.async {
                self.btn.isEnabled = true
            }
            if success == false {
                
                DispatchQueue.main.async{
                    self.alert(error: error!)
                }
            }
           try! self.delegate.stack.saveContext()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        
        
        let frr = NSFetchRequest<Images>(entityName: "Images")
        frr.sortDescriptors = [NSSortDescriptor(key: "pin", ascending: true)]
        let pred = NSPredicate(format: "pin = %@", argumentArray: [self.point])
        frr.predicate = pred
        fetchedResultsController = NSFetchedResultsController(fetchRequest: frr, managedObjectContext: (delegate.stack.context), sectionNameKeyPath: nil, cacheName: nil)
        self.fetchedResultsController?.delegate = self
        self.executeSearch()
        
        if (point.image?.count)! < 1 {
            self.getUrls(){ (success, error) in
                DispatchQueue.main.async{
                    self.btn.isEnabled = true
                }
                if success == false {
                   DispatchQueue.main.async{
                        self.alert(error: error!)
                    }
                }
               try! self.delegate.stack.saveContext()
            }
        } else {
            self.btn.isEnabled = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.indicator.isHidden = false
        cell.indicator.startAnimating()
        cell.image.image = nil
        let obj = fetchedResultsController!.object(at: indexPath) as? Images
        if obj?.image == nil  {
            DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async  {
                let Murl = URL(string:(obj?.url)!)
                let imagedata = try? Data(contentsOf: Murl!)
                self.fetchedResultsController?.managedObjectContext.perform{
                    obj!.image = imagedata! as NSData
                   try! self.delegate.stack.saveContext()
                    cell.image.image = UIImage(data:(obj?.image)! as Data)
                    cell.indicator.stopAnimating()
                    cell.indicator.isHidden = true
                }
            }
        }
        
        
        if obj?.image != nil {
            cell.image.image = UIImage(data:(obj?.image)! as Data)
            cell.indicator.stopAnimating()
            cell.indicator.isHidden = true
        }
        return cell
    }
    
    func  getUrls(_ completion: @escaping (_ done: Bool, _ error: String?) -> Void) {
        let flicker  = Flicker()
        
        
        flicker.getData(lat: self.point.lat, long: self.point.long, page: Int32(arc4random_uniform(50)), completion: {
        error , urlarray in
         if error != nil
         {
           completion(false,error)
            return
            }
         if urlarray?.count == 0
         {
         completion(false,"No Data Found")
            return
        }
            
            for i in urlarray!
            {
                let im = Images(image: nil, point: self.point, context: (self.fetchedResultsController?.managedObjectContext)!)
                im.url = i
                
                
            }
           completion(true,nil)
        
        })
        
        
         }
    
    func alert(error :String )
    {  DispatchQueue.main.async {
        
        
        let alert = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "cancel", style: .default, handler:{
            a in
            self.btn.isEnabled = true
        }))
        self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
        
    func setUp()
    {   map.isUserInteractionEnabled = false
        self.btn.isEnabled = false
        self.collection.delegate = self
        self.collection.dataSource = self
        let cords2d = CLLocationCoordinate2D(latitude: (self.point?.lat)!, longitude: (self.point?.long)!)
        let annoat = MKPointAnnotation()
        annoat.coordinate = cords2d
        map.addAnnotations([annoat])
        map.isScrollEnabled = false
        let span = MKCoordinateSpanMake(2.3, 2.3)
        let reg = MKCoordinateRegionMake(cords2d, span)
        map.setRegion(reg, animated: true)
    }

}
