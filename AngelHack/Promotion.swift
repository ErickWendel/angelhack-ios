//
//  Promotion.swift
//  AngelHack
//
//  Created by Jean Paul Marinho on 16/04/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import Foundation

class Promotion {
    var name: String
    var market: Market?
    var price: Float
    var product: Product?
    var productDate: ProductDate
    
    init(name: String, price: Float, productDate: ProductDate) {
        self.name = name
        self.price = price
        self.productDate = productDate
    }
}