//
//  NotificationsCentral.swift
//  WashnGo
//
//  Created by Jean Paul Marinho on 29/03/16.
//  Copyright © 2016 Iterative. All rights reserved.
//

import Foundation
import SwiftSpinner

class AppNotifications {
    
    class func showAlertController(title: String?, message: String?, presenter: UIViewController, okHandler: ((UIAlertAction) ->Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: okHandler)
        alertController.addAction(okAction)
        presenter.presentViewController(alertController, animated: true, completion: nil)
    }
    
    class func showLoadingIndicator(message: String?) {
        if message != nil {
            SwiftSpinner.show(message!, animated: true)
        }
    }

    class func hideLoadingIndicator() {
        SwiftSpinner.hide()
    }
}