//
//  HomeViewController.swift
//  AngelHack
//
//  Created by Jean Paul Marinho on 16/04/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import UIKit

class PromotionViewController: UIViewController {

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



extension PromotionViewController: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PromotionCollectionViewCell", forIndexPath: indexPath)
        return cell
    }
}



extension PromotionViewController: UICollectionViewDelegate {
    
}



extension PromotionViewController: AppDataDelegate {
    func productIsReadyToShow(product: Product) {
        
    }
    
    func sendProductWithSuccess(success: Bool) {
        
    }
    
    func getMarketWithSuccess(success: Bool) {
        
    }
    
    func getPromotionsWithSuccess(success: Bool) {
        
    }
}
