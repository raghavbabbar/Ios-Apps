//
//  Network.swift
//  DreamListerApp
//
//  Created by raghav babbar on 04/11/17.
//  Copyright © 2017 raghav babbar. All rights reserved.
//

import Foundation



func getPrice(code:String,handler:@escaping(_ error:String?)->())
{
    /*
     https://api.priceapi.com/jobs/token=MRNGJSAWRBCWXVKQDZBYKTZVCPYFMBSJLNDMQHKYHBOIRCQKUTPQKOPSKUZNALRP/country=de/source=google-shopping/currentness=daily_updated/completeness=one_page/key=gtin///values=00885178843303 */
    
    let url = "https://api.priceapi.com/jobs?token=MRNGJSAWRBCWXVKQDZBYKTZVCPYFMBSJLNDMQHKYHBOIRCQKUTPQKOPSKUZNALRP&country=de&source=google-shopping&currentness=daily_updated&completeness=one_page&key=gtin&values=00\(code)"
    
    let request = NSMutableURLRequest(url: URL(string: url)!)
    request.httpMethod = "POST"
    
    let session = URLSession.shared
    
    let  task = session.dataTask(with: request as URLRequest ) { ( data , res, error) in
        
        if error != nil
        {
            
            handler(error?.localizedDescription)
            return
        }
        do{
            let Jdata=try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:Any]
            if let job_id = Jdata!["job_id"] as? String
            {
                
                var detailsUrl = "https://api.priceapi.com/products/bulk/"+"\(job_id)?"
                detailsUrl += "token=MRNGJSAWRBCWXVKQDZBYKTZVCPYFMBSJLNDMQHKYHBOIRCQKUTPQKOPSKUZNALRP"
                print(detailsUrl)
                sleep(5)
                let request2 = NSMutableURLRequest(url: URL(string: detailsUrl)!)
                let task2 = session.dataTask(with: request2 as URLRequest, completionHandler: { ( data, res,error ) in
                    
                    if error != nil
                    {
                        handler(error?.localizedDescription)
                        return
                    }
                    do {
                        var data2=try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as!
                            [String:Any]
                        
                        if let jobstatus = data2["reason"] as? String , jobstatus == "job not finished"
                        {
                            handler("Please Try Again")
                            return
                        }
                        
                        
                        print(data2)
                        if let products = data2["products"] as? [[String:Any]], let productsDict = products[0]["offers"] as? [[String:Any]]
                        {   var p = productsDict[0]
                            Product.name = products[0]["name"] as! String
                            Product.image_url = products[0]["image_url"] as! String
                            Product.shop_name = p["shop_name"] as! String
                            Product.shop_url = p["shop_url"] as! String
                            
                            
                            
                            
                            
                            if let price = p["price"] as? String
                            { print(price)
                                Globaldata.login.job_id = price
                                Product.price = price
                                Product.alter()
                                handler(nil)
                            }
                            else
                            {  handler(Constanskey.Invalid_code)
                                return
                                
                            }
                            
                        }
                        else
                        {  handler(Constanskey.Invalid_code)
                            
                            
                            
                            return
                        }
                        
                        
                        
                        
                    }
                        
                    catch
                    {
                        handler(Constanskey.Invalid_code)
                        return
                    }
                    
                })
                
                
                
                task2.resume()
            }
                
            else
            {  handler(Constanskey.Invalid_code)
                //error
                return
            }
            
        }
        catch
        {
            handler(Constanskey.Invalid_code)
            return
            
        }
    }
    
    task.resume();
}


func get_Job_Id(code : String , handler:@escaping(_ done:Bool? ,_ errorOrJob :String?)->())
{
    var url = "https://api.priceapi.com/jobs?token=MRNGJSAWRBCWXVKQDZBYKTZVCPYFMBSJLNDMQHKYHBOIRCQKUTPQKOPSKUZNALRP&country=de&source=google-shopping&currentness=daily_updated&completeness=one_page&key=gtin&values=00\(code)"
    let  url2 =  URL(string: url)
    if url2 == nil
    {
        handler(false, Constanskey.Invalid_code)
        return
        
    }
    
    
    let request = NSMutableURLRequest(url: url2!)
    request.httpMethod = "POST"
    
    let session = URLSession.shared
    
    let  task = session.dataTask(with: request as URLRequest ) { ( data , res, error) in
        print("POST")
        if error != nil
        {
            
            handler(false,error?.localizedDescription)
            return
        }
        do{
            let Jdata=try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:Any]
            if let job_id = Jdata!["job_id"] as? String
            {  print("job id = \(job_id)")
                handler(true,job_id)
                return
            }
        }
        catch
        {
            handler(false,error.localizedDescription)
        }
    }
    task.resume()
    
}


func get_Data_from_Jobid(job_id : String? , handler:@escaping(_ done:Bool? ,_ errorOrJob :String?,_ jId:String?)->()){
    var detailsUrl = "https://api.priceapi.com/products/bulk/"+"\(job_id!)?"
    detailsUrl += "token=MRNGJSAWRBCWXVKQDZBYKTZVCPYFMBSJLNDMQHKYHBOIRCQKUTPQKOPSKUZNALRP"
    print(detailsUrl)
    
    let request2 = NSMutableURLRequest(url: URL(string: detailsUrl)!)
    let session = URLSession.shared
    let task2 = session.dataTask(with: request2 as URLRequest, completionHandler: { ( data, res, error ) in
        
        if error != nil
        {
            handler(true,error?.localizedDescription,job_id)
            return
        }
        do {
            var data2=try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as!
                [String:Any]
            print("\n------data-------\n")
            print(data2)
            print("\n------data-------\n")
            
            if let jobstatus = data2["reason"] as? String , jobstatus == "job not finished"
            {  print("innn")
                handler(false,"Try Again",job_id)
                return
            }
            if let products = data2["products"] as? [[String:Any]]
            {
                if  let p = products[0] as? [String:Any] ,let str = p["reason"]  as? String , str == "not found"
                {
                    handler(true, "Product Not Found", job_id)
                    return
                }
            }
            
            
            if let products = data2["products"] as? [[String:Any]], let productsDict = products[0]["offers"] as? [[String:Any]]
            {    var p = productsDict[0]
                print("\n---------p--------\n")
                print(p)
                print("\n---------p--------\n")
                
                
                
                Product.name = products[0]["name"] as! String
                Product.image_url = products[0]["image_url"] as! String
                Product.shop_name = p["shop_name"] as! String
                Product.shop_url = p["shop_url"] as! String
                
                
                
                
                
                if let price = p["price"] as? String
                { print(price)
                    Globaldata.login.job_id = price
                    Product.price = price
                    Product.alter()
                    handler(true,nil,job_id)
                }
                else
                {  handler(true,Constanskey.Invalid_code,job_id)
                    return
                    
                }
                
            }
            else
            {  handler(true,Constanskey.Invalid_code,job_id)
                
                
                
                return
            }
            
        }
        catch {
            
            
            
        }
    })
    
    task2.resume()
    
    
    
}

















struct   Globaldata {
    struct login {
        static var key:String = ""
        static var firstName:String = ""
        static var lastName:String = ""
        static var location:String = ""
        static var mediaurl :String = ""
        static var job_id = ""
        
    }
}
struct Constanskey
{
    static let pinAdded="pin added"
    static let baseStudentLoactionURL="https://parse.udacity.com/parse/classes/StudentLocation"
    static let parseAppId="X-Parse-Application-Id"
    static let X_Parse_API="X-Parse-REST-API-Key"
    static let Invalid_code = "Invalid upc code."
}
struct ConstantValue
{
    
    static let parseAppId="QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    static let X_Parse_API="QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    
}





struct Product {
    static var name = ""
    static var image_url = ""
    static var price = ""
    static var shop_name = ""
    static var shop_url = ""
    static func refresh()
    { name = ""
        image_url = ""
        price = ""
        shop_url = ""
        shop_name = ""
    }
    static func alter()
    {   if name.characters.count > 12 {
        name  =  name.substring(to : name.index(name.startIndex, offsetBy: 12)) }
        if shop_name.characters.count > 12 {
            shop_name = shop_name.substring(to: shop_name.index(shop_name.startIndex, offsetBy: 12))
        }
        
    }
}

var dict:[String:Any]!

