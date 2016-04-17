//
//  PromotionsViewController.swift
//  AngelHack
//
//  Created by Jean Paul Marinho on 17/04/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import UIKit

class PromotionsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        AppNotifications.showLoadingIndicator("Obtendo dados dos mercados...")
        AppData.getMarkets()
        AppData.getPromotions()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        AppData.sharedInstance.delegate = self
    }
}



extension PromotionsViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if AppData.sharedInstance.promotionsArray == nil {
            return 0
        }
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (AppData.sharedInstance.promotionsArray?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PromotionsTableViewCell", forIndexPath: indexPath) as! PromotionsTableViewCell
        let promotion = AppData.sharedInstance.promotionsArray![indexPath.row]
        let product = promotion.product
        cell.lblPromotion.text = promotion.campaignName
        let img = product!.image
        let imgURL = NSURL(string: img!)
        cell.imgPromotion.af_setImageWithURL(imgURL!, placeholderImage: UIImage(named: "placeholder"))
        self.view.setNeedsDisplay()
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
}



extension PromotionsViewController: UITableViewDelegate {
    
}



extension PromotionsViewController: AppDataDelegate {
    func productIsReadyToShow(product: Product) {
        
    }
    
    func sendProductWithSuccess(success: Bool) {
        
    }
    
    func getMarketsWithSuccess(success: Bool) {
        AppNotifications.hideLoadingIndicator()
        if success == true {
        }
    }
    
    func getPromotionsWithSuccess(success: Bool) {
        if success == true {
            self.tableView.reloadData()
        }
    }
    
    func getProductsWithSuccess(success: Bool) {
    }
}