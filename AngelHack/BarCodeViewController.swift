//
//  ViewController.swift
//  BarScannerReaderSwift
//
//  Created by Rafael  Hieda on 30/06/15.
//  Copyright (c) 2015 Rafael Hieda. All rights reserved.
//

import UIKit
import AVFoundation 

protocol BarcodeDelegate {
    func barcodeReaded(barcode: String)
}

class BarCodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, AppDataDelegate {
    
    let session = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?
    var delegate: BarcodeDelegate?
    let qrCodeFrameView: UIView = UIView()
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
    func addPreviewLayer() {
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        previewLayer?.bounds = self.view.bounds
        previewLayer?.position = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds))
        self.view.layer.addSublayer(previewLayer!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    
    @IBAction func closeButtonPressed(sender: UIButton) {
    }
    
    @IBAction func checkButtonPressed(sender: UIButton) {
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        for metadata in metadataObjects {
            let readableObject = metadata as! AVMetadataMachineReadableCodeObject
            let barCode = readableObject.stringValue
            if !barCode.isEmpty {
                let barCodeObject = previewLayer!.transformedMetadataObjectForMetadataObject(metadataObjects[0] as! AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
                qrCodeFrameView.frame = barCodeObject.bounds

                self.session.stopRunning()
//                let vc = storyboard?.instantiateViewControllerWithIdentifier("ProductDetailViewController")
//                self.navigationController?.pushViewController(vc!, animated: true)
//                self.delegate?.barcodeReaded(barCode)
                print(barCode)
                GSIAPI.sharedInstance.makeHTTPGetRequest(barCode)
                
            }
        }
    }
    
    func productIsReadyToShow(product: Product) {
        // mostrar o produto na string e imagem
    }
}

