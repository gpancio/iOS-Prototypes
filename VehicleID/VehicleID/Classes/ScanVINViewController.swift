//
//  ScanVINViewController.swift
//  VehicleID
//

import UIKit
import AVFoundation

public protocol ScanVINViewControllerDelegate: class {
    func vinScanned(vin: String)
}

public class ScanVINViewController: UIViewController, BarcodeScannerDelegate {
    
    public weak var delegate: ScanVINViewControllerDelegate?
    
    var scanner = BarcodeScanner()

    @IBOutlet weak var controlsView: UIView!
    @IBOutlet weak var scanArea: UIView!
    var overlayView: UIView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        scanner.delegate = self
        
        overlayView = UIView(frame: self.view.bounds)
        self.view.insertSubview(overlayView, atIndex: 0)
    }
    
    override public func viewDidLayoutSubviews() {
        if let capLayer = scanner.captureLayer {
            capLayer.frame = self.scanArea.frame
            self.view.layer.insertSublayer(capLayer, atIndex: 0)
            scanner.updateVideoOrientation(UIApplication.sharedApplication().statusBarOrientation)
        }
        
        updateOverlay(self.view.bounds)
        view.bringSubviewToFront(controlsView)
    }
    
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if checkCamera() {
            scanner.setupCaptureSession(self.view.bounds)
        }
    }
    
    func updateOverlay(frame : CGRect){
        overlayView.frame = frame
        overlayView.alpha = 0.8
        overlayView.backgroundColor = UIColor.blackColor()
        self.view.bringSubviewToFront(overlayView)
        
        let maskLayer = CAShapeLayer()
        
        // Create a path with the rectangle in it.
        let path = CGPathCreateMutable()
        
        CGPathAddRect(path, nil, CGRectMake(scanArea.frame.origin.x, scanArea.frame.origin.y, scanArea.frame.width, scanArea.frame.height))
        CGPathAddRect(path, nil, CGRectMake(0, 0, overlayView.frame.width, overlayView.frame.height))
        
        maskLayer.backgroundColor = UIColor.blackColor().CGColor
        
        maskLayer.path = path;
        maskLayer.fillRule = kCAFillRuleEvenOdd
        
        // Release the path since it's not covered by ARC.
        overlayView.layer.mask = maskLayer
        overlayView.clipsToBounds = true
    }
    
    @IBAction func ledBtnTapped(sender: AnyObject) {
        scanner.toggleLed()
    }
    
    @IBAction func cancel(sender: AnyObject) {
        goBack()
    }
    
    // MARK: - Camera permissions
    func checkCamera() -> Bool {
        let authStatus = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
        
        if authStatus == .Denied {
            alertPromptToAllowCameraAccessViaSetting()
            return false
        }
        
        return true
    }
    
    func alertPromptToAllowCameraAccessViaSetting() {
        let alert = UIAlertController(
            title: "IMPORTANT",
            message: "VIN scanning requires permission to use the Camera. Use the Settings app to permit access to the camera for scanning.",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .Cancel) { alert in
            if AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo).count > 0 {
                AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo) { granted in
                    dispatch_async(dispatch_get_main_queue()) {
                        if let navController = self.navigationController {
                            navController.popViewControllerAnimated(true)
                        } else {
                            self.dismissViewControllerAnimated(true, completion: nil)
                        }
                    }
                }
            }
            })
        presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: - ScannerDelegate
    
    func setupFailed(reason: String) {
        showErrorAlert("Failed to scan VIN")
    }
    
    func didScan(value: String) {
        delegate?.vinScanned(value)
        goBack()
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
