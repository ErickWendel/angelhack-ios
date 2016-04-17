//
//  HomeViewController.swift
//  AngelHack
//
//  Created by Jean Paul Marinho on 16/04/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppNotifications.showLoadingIndicator("Carregando Produtos...")
        AppData.getProducts()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if AppData.sharedInstance.productsArray == nil {
            return 0
        }
        //        return (AppData.sharedInstance.marketsArray?.count)!
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
