//
//  ViewController.swift
//  BarScannerReaderSwift
//
//  Created by Rafael  Hieda on 30/06/15.
//  Copyright (c) 2015 Rafael Hieda. All rights reserved.
//

import UIKit
import AVFoundation
import AlamofireImage

protocol BarcodeDelegate {
    func barcodeReaded(barcode: String)
}

class BarCodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, AppDataDelegate {
    
    let session = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?
    var delegate: BarcodeDelegate?
    let qrCodeFrameView: UIView = UIView()
    var product: Product?
    
    @IBOutlet weak var productModal: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var imgCarrinho: UIImageView!
    
    func addPreviewLayer() {
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        previewLayer?.bounds = self.view.bounds
        previewLayer?.position = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds))
        self.view.layer.addSublayer(previewLayer!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productName.numberOfLines = 0
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        do {
            let inputDevice = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(inputDevice)
            addPreviewLayer()
            
            qrCodeFrameView.layer.borderColor = UIColor.greenColor().CGColor
            qrCodeFrameView.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView)
            view.bringSubviewToFront(qrCodeFrameView)
            
            let output = AVCaptureMetadataOutput()
            session.addOutput(output)
            output.metadataObjectTypes = output.availableMetadataObjectTypes
            output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
            session.startRunning()
        } catch {
            print("error")
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        AppData.sharedInstance.delegate = self
        imgCarrinho.layer.zPosition = 100
    }
    
    func productModalHandle () {
        session.stopRunning()
        addPreviewLayer()
        session.startRunning()
        self.productModal.hidden = true
        self.imgCarrinho.hidden = false
        self.productImage.image = nil
        self.productName.text = ""
    }
    
    @IBAction func closeButtonPressed(sender: UIButton) {
        productModalHandle()
    }
    
    @IBAction func checkButtonPressed(sender: UIButton) {
        AppNotifications.showLoadingIndicator("Adicionando à sua lista...")
        AppData.sendProduct(self.product!)
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        for metadata in metadataObjects {
            let readableObject = metadata as? AVMetadataMachineReadableCodeObject
            if readableObject != nil {
                let barCode = readableObject!.stringValue
                if !barCode.isEmpty {
                    let barCodeObject = previewLayer!.transformedMetadataObjectForMetadataObject(metadataObjects[0] as! AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
                    qrCodeFrameView.frame = barCodeObject.bounds
                    self.session.stopRunning()
                    self.previewLayer?.removeFromSuperlayer()
                    print(barCode)
                    AppNotifications.showLoadingIndicator("Comunicando-se com o servidor...")
                    GSIAPI.sharedInstance.makeHTTPGetRequest(barCode)
                }
            }
        }
    }
    
    func productIsReadyToShow(product: Product) {
        self.product = product
        AppNotifications.hideLoadingIndicator()
        self.productModal.hidden = false
        imgCarrinho.hidden = true
        self.navigationController?.title = "Teste"
        self.productName.text = product.name!
        guard let img = product.image else {
            return
        }
        
        guard let imgURL = NSURL(string: img) else {
            return
        }
        
        self.productImage.af_setImageWithURL(imgURL, placeholderImage: UIImage(named: "placeholder"))
        
        self.view.setNeedsDisplay()

    }
    
    func sendProductWithSuccess(success: Bool) {
        AppNotifications.hideLoadingIndicator()
        AppNotifications.showAlertController("Item adicionado com sucesso", message: nil, presenter: self) { (UIAlertAction) in
            self.productModalHandle()
        }
    }
    
    func getMarketsWithSuccess(success: Bool) {
    }
    
    func getPromotionsWithSuccess(success: Bool) {
        
    }
    
    func getProductsWithSuccess(success: Bool) {
    }
}

