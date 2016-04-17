//
//  ProductsViewController.swift
//  AngelHack
//
//  Created by Jean Paul Marinho on 16/04/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
        AppNotifications.showLoadingIndicator("Carregando Produtos...")
        AppData.getProducts()
    }
    
    func refresh(sender:AnyObject)
    {
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if AppData.sharedInstance.productsArray == nil {
            return 0
        }
        return (AppData.sharedInstance.productsArray?.count)!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let product = AppData.sharedInstance.productsArray?[indexPath.section]
        let cell = tableView.dequeueReusableCellWithIdentifier("Products") as! PromotionsTableViewCell
        guard let imgURL = NSURL(string: (product?.image)!) else {
            return UITableViewCell()
        }
        cell.imgPromotion.af_setImageWithURL(imgURL, placeholderImage: UIImage(named: "placeholder"))
        cell.lblPromotion.text = product?.name!
        return cell
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        AppData.sharedInstance.delegate = self
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 4
    }  
}

extension ProductsViewController: AppDataDelegate {
    func productIsReadyToShow(product: Product) {
        
    }
    
    func sendProductWithSuccess(success: Bool) {
        
    }
    
    func getMarketsWithSuccess(success: Bool) {
        
    }
    
    func getPromotionsWithSuccess(success: Bool) {
    }
    
    func getProductsWithSuccess(success: Bool) {
        AppNotifications.hideLoadingIndicator()
        if success == true {
            self.tableView.reloadData()
        }
    }
}
