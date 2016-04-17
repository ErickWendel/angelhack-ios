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
    func getProductsWithSuccess(success: Bool)
    func getMarketsWithSuccess(success: Bool)
    func getPromotionsWithSuccess(success: Bool)
}

class AppData {
    static let sharedInstance = AppData()
    var delegate: AppDataDelegate?
    var installationObjectID: String?
    var promotionsArray: [Promotion]?
    var productsArray: [Product]?
    var marketsArray: [Market]?
    var currentMarketIndex: Int?

    class func getPromotions() {
        AppData.sharedInstance.promotionsArray = Array()
        let query = PFQuery(className: "Promotion")
        query.includeKey("product")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) in
            for object in objects! {
                let promotion = Promotion()
                promotion.campaignName = object["campaignName"] as? String
                promotion.price = object["price"] as? Float
                
                let prod = object["product"] as! PFObject
                let product = Product()
                product.image = prod["image"] as? String
                promotion.product = product
                AppData.sharedInstance.promotionsArray?.append(promotion)
                AppData.sharedInstance.delegate?.getPromotionsWithSuccess(true)
            }
        }
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
        query.getObjectInBackgroundWithId((AppData.sharedInstance.marketsArray?[AppData.sharedInstance.currentMarketIndex!].objectID!)!) { (object: PFObject?, error: NSError?) in
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
    
    class func getProducts() {
        AppData.sharedInstance.productsArray = Array()
        let query = PFQuery(className: "Product")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) in
            for object in objects! {
                let product = Product()
                product.name = object["name"] as? String
                product.image = object["image"] as? String
                product.id = object.objectId
                AppData.sharedInstance.productsArray!.append(product)
            }
            AppData.sharedInstance.delegate?.getProductsWithSuccess(true)
        }
        
    }
    
    class func getMarkets() {
        AppData.sharedInstance.marketsArray = Array()
        let query = PFQuery(className: "Market")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) in
            if error == nil {
                for object in objects! {
                    let latitude = object["latitude"] as? String
                    let market = Market()
                    market.objectID = object.objectId!
                    market.name = object["name"] as? String
                    market.latitude = latitude
                    market.longitude = object["longitude"] as? String
                    market.address = object["address"] as? String
                    if latitude == AppLocation.sharedInstance.latitude! {
                        AppData.sharedInstance.currentMarketIndex = AppData.sharedInstance.marketsArray?.count
                    }
                    AppData.sharedInstance.marketsArray?.append(market)
                }
                AppData.sharedInstance.delegate?.getMarketsWithSuccess(true)
            }
        }
    }
}