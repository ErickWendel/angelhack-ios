//
//  AppData.swift
//  AngelHack
//
//  Created by Jean Paul Marinho on 16/04/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import Foundation

class AppDataDelegate {
    
}

class AppData {
    static let sharedInstance = AppData()
    var delegate: AppDataDelegate?
    var promotionsArray: [Promotion]?

    class func getPromotions() {
        let promotion = Promotion()
        promotion.name = "Fandangos 50%OFF"
    }
}