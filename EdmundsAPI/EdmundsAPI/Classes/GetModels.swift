//
//  GetModels.swift
//  EdmundsAPI
//
//  Created by Graham Pancio on 2016-04-27.
//  Copyright © 2016 Graham Pancio. All rights reserved.
//

import Foundation

import Alamofire
import AlamofireObjectMapper

public protocol GetModelsDelegate: class {
    func onSuccess(models: [String])
    func onFail()
}

/**
 Retrieves vehicle models using the Edmunds Vehicle API.
 */
public class GetModels {
    public weak var delegate: GetModelsDelegate?
    
    var apiKey: String
    
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    public func makeRequest(year: String, make: String) {
        Alamofire.request(Method.GET, formatUrl(year, make: make)).validate().responseObject { (response: Response<VehicleModelSet, NSError>) in
            let dataSet = response.result.value
            
            if dataSet != nil && dataSet?.models != nil && dataSet?.models?.count > 0 {
                self.delegate?.onSuccess(dataSet?.modelsArray ?? [])
            } else {
                self.delegate?.onFail()
            }
        }
    }
    
    private func formatUrl(year: String, make: String) -> String {
        let urlString = String(format: "https://api.edmunds.com/api/vehicle/v2/%@/models?fmt=json&year=%@&api_key=%@", make, year, apiKey)
        return urlString
    }
    
}