//
//  VINDecoderFactory.swift
//

import Foundation
import EdmundsAPI

protocol VINDecoder {
    func decodeVIN(vin: String)
    var vinDelegate: VINDecoderDelegate? { get set }
}

extension VINDecoder: VINDecoder {
    func decodeVIN(vin: String) { self.decodeVIN(vin) }
    
    var vinDelegate: VINDecoderDelegate? {
        get { return self.delegate }
        set { self.delegate = newValue }
    }
}

class OfflineVINDecoder: VINDecoder {
    
    let vehicle = Vehicle(year: 2008, make: "Volkswagen", model: "GTI")
    
    func decodeVIN(vin: String) {
        self.delegate?.vinDecodeSuccess(vehicle)
    }
    
    weak var delegate: VINDecoderDelegate?
    
    var vinDelegate: VINDecoderDelegate? {
        get { return delegate }
        set { self.delegate = newValue }
    }
}

func createVINDecoder() -> VINDecoder {
    let userDefaults = NSUserDefaults.standardUserDefaults()
    let offline = userDefaults.boolForKey("offline")
    return offline ? OfflineVINDecoder() : AudaExploreVINDecoder()
}

