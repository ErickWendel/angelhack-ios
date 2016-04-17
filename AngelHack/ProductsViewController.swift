//
//  HomeViewController.swift
//  AngelHack
//
//  Created by Jean Paul Marinho on 16/04/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        AppNotifications.showLoadingIndicator("Carregando Produtos...")
        AppData.getProducts()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        AppData.sharedInstance.delegate = self
    }
}



extension ProductsViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if AppData.sharedInstance.productsArray == nil {
            return 0
        }
//        return (AppData.sharedInstance.marketsArray?.count)!
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (AppData.sharedInstance.productsArray?.count)!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let product = AppData.sharedInstance.productsArray?[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! ProductsCollectionViewCell
        guard let imgURL = NSURL(string: (product?.image)!) else {
            return UICollectionViewCell()
        }
        cell.productImage.af_setImageWithURL(imgURL, placeholderImage: UIImage(named: "placeholder"))
        cell.label.text = product?.name!
        return cell
    }
}



extension ProductsViewController: UICollectionViewDelegate {
    
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
            self.collectionView.reloadData()
        }
    }
}
