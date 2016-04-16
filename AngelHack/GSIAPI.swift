//
//  CosmosAPI.swift
//  testeBarCode
//
//  Created by Vivian Dias on 05/02/16.
//  Copyright © 2016 Vivian Dias. All rights reserved.
//

import UIKit

//typealias ServiceResponse = (JSON, NSError?) -> Void

class GSIAPI: NSObject {
    
    static let sharedInstance = GSIAPI()
    
    func makeHTTPGetRequest(code: String) {
        let baseURL = "http://inbar-producao-ws.azurewebsites.net/search"
        
        let request = NSMutableURLRequest(URL: NSURL(string: baseURL)!)
        let session = NSURLSession.sharedSession()
        
        request.HTTPMethod = "POST"
        
        do{
            let json = ["codeType":"GTIN", "code": code]
            let data = try NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
        
            request.timeoutInterval = 60
            request.HTTPBody = data
            request.addValue("62a7970e-1a72-494d-a27a-90d15cfba392", forHTTPHeaderField: "secret")
            request.addValue("hackathon-team-01188", forHTTPHeaderField: "deviceid")
            request.addValue("no-cache", forHTTPHeaderField: "cache-control")
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
            var finalResult: NSDictionary?
            let task = session.dataTaskWithRequest(request) { data, response, error -> Void in
                guard data != nil else {
                    print("no data found: \(error)")
                    return
                }
            
            
                do{
                    let jsonResult: NSDictionary! = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? NSDictionary
                
                    if jsonResult != nil {
                        print(jsonResult)
                        finalResult = jsonResult
                    }
                
                }catch let err {
                    print("Errorrrrrrrr \(err)")
                }
            
            
            }
        
        
            task.resume()
        } catch let err {
            print(err)
        }
    }
}


