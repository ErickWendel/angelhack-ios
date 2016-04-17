//
//  PromotionsViewController.swift
//  AngelHack
//
//  Created by Jean Paul Marinho on 16/04/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import UIKit

class PromotionsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl = UIRefreshControl()
        self.refreshControl.tintColor = UIColor.whiteColor()
        let attributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont.systemFontOfSize(17)]
        self.refreshControl.attributedTitle = NSAttributedString(string: "Puxe para atualizar...", attributes: attributes)
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(self.refreshControl)
        AppNotifications.showLoadingIndicator("Obtendo dados dos mercados...")
        AppData.getMarkets()
        AppData.getPromotions()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        AppData.sharedInstance.delegate = self
    }
    
    func refresh(sender:AnyObject)
    {
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
}



extension PromotionsViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if AppData.sharedInstance.promotionsArray == nil {
            return 0
        }
        return (AppData.sharedInstance.promotionsArray?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PromotionsTableViewCell", forIndexPath: indexPath) as! PromotionsTableViewCell
        let promotion = AppData.sharedInstance.promotionsArray![indexPath.row]
        let product = promotion.product
        cell.lblPromotion.text = promotion.campaignName
        cell.labelPrice.text = String(format: "R$ %.2f", promotion.price!)
        let img = product!.image
        let imgURL = NSURL(string: img!)
        cell.imgPromotion.af_setImageWithURL(imgURL!, placeholderImage: UIImage(named: "placeholder"))
        
        
        let market = promotion.market
        cell.labelMarketName.text = market?.name
        
        self.view.setNeedsDisplay()
        return cell
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 4
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let voucher = UITableViewRowAction(style: .Normal, title: "Gerar Voucher") { action, index in
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Voucher") as! DetalhesPromoViewController
            vc.promotion = AppData.sharedInstance.promotionsArray![indexPath.row]
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        voucher.backgroundColor = UIColor ( red: 0.0, green: 0.6416, blue: 0.0002, alpha: 0.802919130067568 )
        return [voucher]
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
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