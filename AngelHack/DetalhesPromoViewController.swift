//
//  DetalhesPromoViewController.swift
//  AngelHack
//
//  Created by Vivian Dias on 17/04/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import UIKit
import Parse

class DetalhesPromoViewController: UIViewController {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var qrcodeImg: UIImageView!
    @IBOutlet weak var barcodeLbl: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    
    var promotion: Promotion?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        createQRCode()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createQRCode(){
        AppNotifications.showLoadingIndicator("Carregando QRCode")
        
        //let code: String = (promotion?.product?.id)! + PFInstallation.currentInstallation().installationId
        let urlString = "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=djjdjdjdjd"
        
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            if error != nil {
                return
            } else {
                self.qrcodeImg.image = UIImage(data: data!)
                //self.barcodeLbl.text = code
                AppNotifications.hideLoadingIndicator()
            }
        }
        
        task.resume()
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
