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
    var promotionsArray: [Promotion]?

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
        let object = PFObject(className: "Product")
        object["name"] = product.name!
        object["id"] = product.id!
        object["image"] = product.image!
        object.saveInBackgroundWithBlock { (success: Bool, error: NSError?) in
            AppData.sharedInstance.delegate?.sendProductWithSuccess(true)
        }
    }
}