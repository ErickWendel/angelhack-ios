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
        
        // Do any additional setup after loading the view.
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func barcodeButtonPressed(sender: UIButton) {
        AppData.getMarket()
        performSegueWithIdentifier("toBarcodeScanner", sender: nil)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
