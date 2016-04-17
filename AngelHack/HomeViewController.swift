//
//  HomeViewController.swift
//  AngelHack
//
//  Created by Vivian Dias on 16/04/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var barcodeButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var msgLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        AppLocation.sharedInstance.start()
        tableView.delegate = self
        barcodeButton.alpha = 0
        tableView.alpha = 0
        msgLbl.alpha = 0
        var t = CGAffineTransformIdentity
        t = CGAffineTransformTranslate(t, 0, self.view.frame.height / 2 - self.logoImage.frame.height)
        t = CGAffineTransformScale(t, 1.5, 1.5)
        self.logoImage.transform = t
        UIView.animateWithDuration(1.0) {
            self.logoImage.transform = CGAffineTransformIdentity
            self.barcodeButton.alpha = 1
            self.tableView.alpha = 1
            self.msgLbl.alpha = 1
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        AppData.sharedInstance.delegate = self
    }
    
    @IBAction func barcodeButtonPressed(sender: UIButton) {
        AppNotifications.showLoadingIndicator("Obtendo dados do mercado atual...")
        AppData.getMarket()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("produto", forIndexPath: indexPath) 
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
}



extension HomeViewController: AppDataDelegate {
    func productIsReadyToShow(product: Product) {
        
    }
    
    func sendProductWithSuccess(success: Bool) {
        
    }

    func getMarketWithSuccess(success: Bool) {
        AppNotifications.hideLoadingIndicator()
        if success == true {
            performSegueWithIdentifier("toBarcodeScanner", sender: nil)
        }
    }
}
