//
//  GetMakes.swift
//  EdmundsAPI
//
//  Created by Graham Pancio on 2016-04-27.
//  Copyright © 2016 Graham Pancio. All rights reserved.
//

import Foundation

import Alamofire
import AlamofireObjectMapper

public protocol GetMakesDelegate: class {
    func onSuccess(makes: [String])
    func onFail()
}

/**
 Retrieves vehicle makes using the Edmunds Vehicle API.
 */
public class GetMakes {
    public weak var delegate: GetMakesDelegate?
    
    var apiKey: String
    
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    public func makeRequest(year: String) {
        Alamofire.request(Method.GET, formatUrl(year)).validate().responseObject { (response: Response<VehicleMakeSet, NSError>) in
            let makeSet = response.result.value
            
            if makeSet != nil && makeSet?.makes != nil && makeSet?.makes?.count > 0 {
                self.delegate?.onSuccess(makeSet?.makesArray ?? [])
            } else {
                self.delegate?.onFail()
            }
        }
    }
    
    private func formatUrl(year: String) -> String {
        let urlString = String(format: "https://api.edmunds.com/api/vehicle/v2/makes?fmt=json&year=%@&api_key=%@", year, apiKey)
        return urlString
    }
    
}