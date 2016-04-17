//
//  AppData.swift
//  AngelHack
//
//  Created by Jean Paul Marinho on 16/04/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import Foundation
import Alamofire
import Parse

protocol AppDataDelegate {
    func productIsReadyToShow(product: Product)
    func sendProductWithSuccess(success: Bool)
}

class AppData {
    static let sharedInstance = AppData()
    var delegate: AppDataDelegate?
    var installationObjectID: String?
    var promotionsArray: [Promotion]?
    var currentMarket: Market?

    class func getPromotions() {
        Alamofire.request(.GET, "https://httpbin.org/get")
        let promotion = Promotion()
        promotion.name = "Fandangos 50%OFF"
    }
    
    class func setProduct(json: NSDictionary, GTIN: String) {
        if let responseDTO = json["ResponseDTO"] as? NSDictionary {
            if let responseItems = responseDTO["ResponseItems"] as? NSArray {
                if let response = responseItems.firstObject as? NSDictionary {
                    
                    let product = Product()
                    product.name = response["Descricao"] as? String
                    product.id = GTIN
                    product.image = response["Imagem1"] as? String
                    AppData.sharedInstance.delegate?.productIsReadyToShow(product)
                }
            }
        }
    }
    
    class func sendProduct(product: Product) {
        let query = PFQuery(className: "Market")
        query.getObjectInBackgroundWithId((AppData.sharedInstance.currentMarket?.objectID!)!) { (object: PFObject?, error: NSError?) in
            let productObject = PFObject(className: "Product")
            productObject["name"] = product.name!
            productObject["id"] = product.id!
            productObject["image"] = product.image!
            let relation = productObject.relationForKey("market")
            relation.addObject(object!)
            productObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) in
                AppData.sharedInstance.delegate?.sendProductWithSuccess(true)
            }
        }
    }
    
    class func getMarket() {
        let query = PFQuery(className: "Market")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) in
            if error != nil {
                for object in objects! {
                    let latitude = object["latitude"] as? String
                    if latitude == AppLocation.sharedInstance.latitude! {
                        let market = Market()
                        market.objectID = object.objectId!
                        market.name = object["name"] as? String
                        market.latitude = latitude
                        market.longitude = object["longitude"] as? String
                        market.address = object["address"] as? String
                        AppData.sharedInstance.currentMarket = market
                    }
                }
            }
        }
    }
}