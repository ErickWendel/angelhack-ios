//
//  HomeViewController.swift
//  AngelHack
//
//  Created by Vivian Dias on 16/04/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var barcodeButton: UIButton!
    @IBOutlet weak var msgLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        AppLocation.sharedInstance.start()
        barcodeButton.alpha = 0
        msgLbl.alpha = 0
        var t = CGAffineTransformIdentity
        t = CGAffineTransformTranslate(t, 0, self.view.frame.height / 2 - self.logoImage.frame.height)
        t = CGAffineTransformScale(t, 1.1, 1.1)
        self.logoImage.transform = t
        UIView.animateWithDuration(1.0) {
            self.logoImage.transform = CGAffineTransformIdentity
            UIView.animateWithDuration(1.0, animations: {
                self.barcodeButton.alpha = 1
                self.msgLbl.alpha = 1
            })

        }
        AppData.getMarkets()
    }
    
    @IBAction func barcodeButtonPressed(sender: UIButton) {
        performSegueWithIdentifier("toBarcodeScanner", sender: nil)
    }
}