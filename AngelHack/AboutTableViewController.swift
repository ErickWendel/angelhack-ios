//
//  AboutTableViewController.swift
//  AngelHack
//
//  Created by João Marcos on 17/04/16.
//  Copyright © 2016 Jean Paul Marinho. All rights reserved.
//

import UIKit
import MessageUI
import Social

class AboutTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var labelVersion: UILabel!
    
    let version: AnyObject! = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"]
    @IBAction func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func likeFacebook(sender: AnyObject) {
        let facebookURL = NSURL(string: "fb://pages/1664258017164842")!
        if UIApplication.sharedApplication().canOpenURL(facebookURL) {
            UIApplication.sharedApplication().openURL(facebookURL)
        } else {
            UIApplication.sharedApplication().openURL(NSURL(string: "https://www.facebook.com/Followtv")!)
        }
    }
    
    @IBAction func shareFacebook(sender: AnyObject) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
            let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookSheet.setInitialText("Show de App")
            facebookSheet.addURL(NSURL(string: "https://www.facebook.com/JRFilmes"))
            facebookSheet.addImage(UIImage(named: "icon"))
            self.presentViewController(facebookSheet, animated: true, completion: nil)
        } else {
            let alert: UIAlertController = UIAlertController(title: "Facebook", message: "Faça login no facebook", preferredStyle: .Alert)
            let actionOk: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(actionOk)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func shareTwitter(sender: AnyObject) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
            let twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterSheet.setInitialText("Show de app - @apppromoon #PromoOn")
            self.presentViewController(twitterSheet, animated: true, completion: nil)
        } else {
            let alert: UIAlertController = UIAlertController(title: "Twitter", message: "Faça login no twitter", preferredStyle: .Alert)
            let actionOk: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(actionOk)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func contact(sender: AnyObject) {
        if MFMailComposeViewController.canSendMail() {
            let email = MFMailComposeViewController()
            email.mailComposeDelegate = self
            email.setToRecipients(["appfollowtv@gmail.com"])
            email.setSubject("Desenvolvedores Promoon")
            email.setMessageBody("", isHTML: true)
            
            presentViewController(email, animated: true, completion: nil)
        } else {
            let alert: UIAlertController = UIAlertController(title: "E-mail", message: "Configure o uso do seu e-mail", preferredStyle: .Alert)
            let actionOk: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(actionOk)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func rate(sender: AnyObject) {
        let url  = NSURL(string: "itms-apps://itunes.apple.com/app/runroute/id986897571")
        if UIApplication.sharedApplication().canOpenURL(url!) == true  {
            UIApplication.sharedApplication().openURL(url!)
        }
    }
    
    @IBAction func version(sender: AnyObject) {
        let alert: UIAlertController = UIAlertController(title: "Versão", message: "Versão atual: \(version)", preferredStyle: .Alert)
        let actionOk: UIAlertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(actionOk)
        self.presentViewController(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        labelVersion.text = "\(version)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
