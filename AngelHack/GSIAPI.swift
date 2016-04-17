//
//  CosmosAPI.swift
//  testeBarCode
//
//  Created by Vivian Dias on 05/02/16.
//  Copyright © 2016 Vivian Dias. All rights reserved.
//

import UIKit
import Alamofire

//typealias ServiceResponse = (JSON, NSError?) -> Void

class GSIAPI: NSObject {
    
    static let sharedInstance = GSIAPI()
    
    func makeHTTPGetRequest(code: String) {
        print(code)
        let baseURL = "http://inbar-producao-ws.azurewebsites.net/search"
        
        
        let header = ["secret":"62a7970e-1a72-494d-a27a-90d15cfba392",
                      "deviceid": "hackathon-team-01188",
                      "cache-control":"no-cache"]
                      //"content-type" : "application/x-www-form-urlencoded"
        
        
        let parameters = ["code" : code,
                          "codeType" : "GTIN"]
        
        
        Alamofire.request(.POST, baseURL, parameters: parameters, encoding: .JSON, headers: header).responseJSON { (response) in
            switch response.result {
            case .Success(let JSON):
                print(JSON)
            case .Failure(let error):
                print("DEU RUIM!")
            }
        }
    }
}


