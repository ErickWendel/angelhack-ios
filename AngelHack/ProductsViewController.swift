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
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        AppData.sharedInstance.delegate = self
    }
}



extension ProductsViewController: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return (AppData.sharedInstance.marketsArray?.count)!
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PromotionCollectionViewCell", forIndexPath: indexPath) as! ProductsCollectionViewCell
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
}
