//
//  GSIAPI.swift
//  AngelHack
//
//  Created by Jean Paul Marinho on 16/04/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import UIKit
import Alamofire

class GSIAPI: NSObject {
    
    static let sharedInstance = GSIAPI()
    
    func makeHTTPGetRequest(code: String) {
        let baseURL = "http://inbar-producao-ws.azurewebsites.net/search"
        
        let header = ["secret":"62a7970e-1a72-494d-a27a-90d15cfba392",
                      "deviceid": "hackathon-team-01188",
                      "cache-control":"no-cache"]
        
        let parameters = ["code" : code,
                          "codeType" : "GTIN"]
        
        Alamofire.request(.POST, baseURL, parameters: parameters, encoding: .JSON, headers: header).responseJSON { (response) in
            switch response.result {
            case .Success(let JSON):
//                print(JSON)
                AppData.setProduct(JSON as! NSDictionary, GTIN: code)
            case .Failure(let error):
                print("error \(error)")
            }
        }
    }
}


