//
//  ProductDetailViewController.swift
//  AngelHack
//
//  Created by Ricardo Hochman on 16/04/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController, BarcodeDelegate {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func barcodeReaded(barcode: String) {
        let api = GSIAPI().makeHTTPGetRequest(barcode)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
