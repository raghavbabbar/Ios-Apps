//
//  NetworkCall.swift
//  On the Map
//
//  Created by raghav babbar on 13/08/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import UIKit
import Foundation
import MapKit
func getStudentData(responsee:@escaping(_ error:String?)->() )
{
    
    let request = NSMutableURLRequest(url: URL(string:ConstansUrl.studentsurl )!)
    request.addValue(ConstantValue.parseAppId , forHTTPHeaderField:
        Constanskey.parseAppId)
    request.addValue(ConstantValue.X_Parse_API, forHTTPHeaderField:
        Constanskey.X_Parse_API)
    
    let session = URLSession.shared
    let task = session.dataTask(with: request as URLRequest) { data, response, error in
        if error != nil
        {
            responsee(error?.localizedDescription)
            return
            
        }
        
        
        
        
        do{
            let Parseddata1=try JSONSerialization.jsonObject(with: data!,  options: .allowFragments) as! [String:Any]
            let parseddata = Parseddata1["results"] as! [[String:Any]]
            Globaldata.personData = [Person]()
            Globaldata.annoiation = [MKPointAnnotation]()
            for data in parseddata
            {
                let person=Person(obj: data)
                let anno=person.getAnnotion()
                Globaldata.addToGlobalData(person: person, anno )
            }
        }
        catch
        {
            
            
        }
        
        NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: Constanskey.pinAdded)))
        
    }
    task.resume()
}
func validateLogin(name:String,password:String,  responsee:@escaping(_ error:String?)->())
{
    let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = "{\"udacity\": {\"username\": \"\(name)\", \"password\": \"\(password)\"}}".data(using: String.Encoding.utf8)
    let session = URLSession.shared
    let task = session.dataTask(with: request as URLRequest) { data, response, error in
        if(error != nil )
        {
            DispatchQueue.main.async {
                
                responsee(  error?.localizedDescription)
            }
            return
            
        }
        
        
        let range = Range(5..<data!.count)
        let newData = data?.subdata(in: range)
        (NSString(data: newData!, encoding: String.Encoding.utf8.rawValue)!)
        do{
            let data=try JSONSerialization.jsonObject(with: newData!, options: .allowFragments) as! [String:Any]
            if (data["status"] as? Double) != nil
            {
                
                
                DispatchQueue.main.async {
                    
                    responsee("Invalid Details")
                }
                return
                
                
                
            }
                
            else
            {
                let dict = data["account"] as! [String:Any]
                Globaldata.login.key = dict["key"] as! String;
                let url=URL(string: "https://www.udacity.com/api/users/\(Globaldata.login.key)")
                var requestUrl =   URLRequest(url:  url!)
                requestUrl.addValue(ConstantValue.parseAppId, forHTTPHeaderField: Constanskey.parseAppId )
                requestUrl.addValue(ConstantValue.X_Parse_API , forHTTPHeaderField: Constanskey.X_Parse_API )
                requestUrl.addValue("application/json", forHTTPHeaderField: "Accept")
                requestUrl.addValue("application/json", forHTTPHeaderField: "Content-Type");
                let session = URLSession.shared
                
                let task = session.dataTask(with: requestUrl, completionHandler: { (Data,URLResponse, Error) in
                    
                    let range = Range(5..<Data!.count)
                    let newData = Data?.subdata(in: range)
                    do{
                        let apidata = try JSONSerialization.jsonObject(with: newData!, options: .allowFragments   ) as! [String : Any]
                        if let userdata = apidata["user"] as? [String:Any] ,let firstname = userdata["first_name"]  as? String , let lastname = userdata["last_name"] as? String
                        {
                            Globaldata.login.firstName=firstname
                            Globaldata.login.lastName=lastname
                            
                            DispatchQueue.main.async {
                                responsee(nil)
                            }
                        }
                            
                        else
                        {     DispatchQueue.main.async {
                            responsee("error in logging in") }
                            return
                        }
                    }
                    catch
                    {
                        DispatchQueue.main.async {
                            responsee("error in logging in ")
                        }
                        
                    }
                    
                })
                
                
                task.resume()
                
            }
        }
        catch
        {
            
            
        }
        
        
        
    }
    task.resume()
}
func getStudentLocation(cHandler:@escaping ()->())
{
    
    let locationURL =  urlForRequest(apiMethod:"/StudentLocation", parameters: [ParameterKeys.Where: "{\"\(ParameterKeys.uniqueKey)\":\"  " + "\(Globaldata.login.key)"  + "\"}" as AnyObject])
    
    
    
    let request = NSMutableURLRequest(url: locationURL)
    request.addValue(ConstantValue.parseAppId, forHTTPHeaderField: Constanskey.parseAppId)
    request.addValue(ConstantValue.X_Parse_API, forHTTPHeaderField: Constanskey.X_Parse_API)
    let session = URLSession.shared
    
    let task = session.dataTask(with: request as URLRequest) { data, response, error in
        if error != nil
        {
            
            return
        }
        do{
            let  mdata = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments ) as! [String:Any]
            let results = mdata["results"] as! [[String:Any]]
            if  results.count == 0
            {
                DispatchQueue.main.sync {
                    
                    
                    cHandler()
                }
            }
            else
            {
                DispatchQueue.main.sync{
                    Globaldata.login = Person(obj: results[0])
                    
                }
                
            }
            
        }
        catch
        {
            
        }
        
    }
    task.resume()
    
}


func logoutCall(handler:@escaping (_ message : String?)->())
{
    let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
    request.httpMethod = "DELETE"
    var xsrfCookie: HTTPCookie? = nil
    let sharedCookieStorage = HTTPCookieStorage.shared
    for cookie in sharedCookieStorage.cookies! {
        if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
    }
    if let xsrfCookie = xsrfCookie {
        request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
    }
    let session = URLSession.shared
    let task = session.dataTask(with: request as URLRequest) { data, response, error in
        if error != nil {
            handler( error?.localizedDescription)
            return
        }
        else{
            handler(nil)
        }
        let range = Range(5..<data!.count)
        _ = data?.subdata(in: range) /* subset response data! */
    }
    task.resume()
}
func postLocation(httpmethod:String,obj:String? , respon:@escaping (_ error :String?)->())
{
    
    UIApplication.shared.beginIgnoringInteractionEvents()
    
    
    let request = NSMutableURLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation\(obj ?? "")")!)
    request.addValue(ConstantValue.parseAppId, forHTTPHeaderField: Constanskey.parseAppId )
    request.addValue(ConstantValue.X_Parse_API , forHTTPHeaderField: Constanskey.X_Parse_API )
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = "{\"uniqueKey\": \"\(Globaldata.login.key)\", \"firstName\": \"\(Globaldata.login.firstName)\", \"lastName\": \"\(Globaldata.login.lastName)\",\"mapString\": \"\(Globaldata.login.mapString)\", \"mediaURL\": \"\(Globaldata.login.url)\",\"latitude\": \(Globaldata.login.lat) , \"longitude\":  \(Globaldata.login.long)}".data(using: String.Encoding.utf8)
    
    
    request.httpMethod =  httpmethod
    let session = URLSession.shared
    let task = session.dataTask(with: request as URLRequest) { data, response, error in
        
        if error != nil {
            UIApplication.shared.endIgnoringInteractionEvents()
            respon(error?.localizedDescription)
            return
        }
        
        let data = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
        if obj == nil
        {   UIApplication.shared.endIgnoringInteractionEvents()
            Globaldata.login.objId = data["objectId"] as! String
        }
        UIApplication.shared.endIgnoringInteractionEvents()
        respon(nil)
        
    }
    task.resume()
    
    
}

