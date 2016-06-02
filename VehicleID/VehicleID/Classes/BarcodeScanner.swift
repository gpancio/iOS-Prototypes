//
//  BarcodeScanner.swift
//  VehicleID
//

import Foundation
import AVFoundation

protocol BarcodeScannerDelegate: class {
    func setupFailed(reason: String)
    func didScan(value: String)
}

public class BarcodeScanner: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    let captureSession = AVCaptureSession()
    var captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    var captureLayer: AVCaptureVideoPreviewLayer?
    
    weak var delegate: BarcodeScannerDelegate?
    
    public func toggleLed() {
        if captureDevice.hasTorch {
            do {
                try captureDevice.lockForConfiguration()
                
                if captureDevice.torchMode == .Off && captureDevice.isTorchModeSupported(.On) {
                    captureDevice.torchMode = .On
                } else {
                    captureDevice.torchMode = .Off
                }
            } catch {
                return
            }
        }
    }

    public func setupCaptureSession(previewLayerFrame: CGRect) {
        let deviceInput:AVCaptureDeviceInput
        do {
            deviceInput = try AVCaptureDeviceInput(device: captureDevice)
        } catch {
            delegate?.setupFailed("Failed to get AVCaptureDeviceInput")
            return
        }
        
        if (captureSession.canAddInput(deviceInput)) {
            // Show live feed
            captureSession.addInput(deviceInput)
            setupPreviewLayer(previewLayerFrame, completion: {
                self.captureSession.startRunning()
                self.addMetaDataCaptureOutToSession()
            })
        } else {
            delegate?.setupFailed("Error while setting up input captureSession.")
        }
    }
    
    func updateVideoOrientation(uiOrientation: UIInterfaceOrientation) {
        switch uiOrientation {
        case .Portrait:
            captureLayer!.connection.videoOrientation = AVCaptureVideoOrientation.Portrait
        case .LandscapeLeft:
            captureLayer!.connection.videoOrientation = AVCaptureVideoOrientation.LandscapeLeft
        case .LandscapeRight:
            captureLayer!.connection.videoOrientation = AVCaptureVideoOrientation.LandscapeRight
        default:
            captureLayer!.connection.videoOrientation = AVCaptureVideoOrientation.Portrait
        }
    }
    
    /**
     * Handles setting up the UI to show the camera feed.
     - parameter completion: Completion handler to invoke if setting up the feed was successful.
     */
    private func setupPreviewLayer(capLayerFrame: CGRect, completion:() -> ()) {
        self.captureLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        if let capLayer = self.captureLayer {
            capLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            capLayer.frame = capLayerFrame
            completion()
        } else {
            delegate?.setupFailed("An error occured beginning video capture")
        }
    }
    
    // MARK: Metadata capture
    /**
     * Handles identifying what kind of data output we want from the session, in our case, metadata and the available types of metadata.
    */
    private func addMetaDataCaptureOutToSession() {
        let metadata = AVCaptureMetadataOutput()
        self.captureSession.addOutput(metadata)
        metadata.metadataObjectTypes = metadata.availableMetadataObjectTypes
        metadata.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
    }
    
    public func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        for metadata in metadataObjects{
            if let decodedData:AVMetadataMachineReadableCodeObject = metadata as? AVMetadataMachineReadableCodeObject {
                delegate?.didScan(decodedData.stringValue)
                self.captureSession.stopRunning()
            }
        }
    }


}
