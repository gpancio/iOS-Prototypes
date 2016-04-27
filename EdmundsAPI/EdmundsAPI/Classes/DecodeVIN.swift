//
//  DecodeVIN.swift
//  EdmundsAPI
//
//  Created by Graham Pancio on 2016-04-27.
//  Copyright © 2016 Graham Pancio. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

public protocol DecodeVINDelegate: class {
    func vinDecoded(vehicle: Vehicle)
    func vinDecodeFailed()
    func invalidInput()
}


/**
 Decodes a VIN using the Edmunds Vehicle API.
 */
public class DecodeVIN {
    
    public weak var delegate: DecodeVINDelegate?
    
    var apiKey: String
    
    var vin: String?
    
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    /**
     Decodes a VIN.
     
     vin- The VIN to decode. A VIN must be 17 characters long.
     */
    public func makeRequest(vin: String) {
        guard vin.characters.count == 17 else {
            self.delegate?.invalidInput()
            return
        }
        
        self.vin = vin
        Alamofire.request(Method.GET, formatUrl(vin)).validate().responseObject { (response: Response<Vehicle, NSError>) in
            let vehicle = response.result.value
            if vehicle != nil {
                vehicle!.vin = self.vin
                self.delegate?.vinDecoded(vehicle!)
            } else {
                self.delegate?.vinDecodeFailed()
            }
            
        }
    }
    
    private func formatUrl(vin: String) -> String {
        let urlString = String(format: "https://api.edmunds.com/api/vehicle/v2/vins/%@?fmt=json&api_key=%@", vin, apiKey)
        return urlString
    }
    
}