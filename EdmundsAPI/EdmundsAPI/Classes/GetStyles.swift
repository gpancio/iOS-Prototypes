//
//  GetStyles.swift
//  EdmundsAPI
//
//  Created by Graham Pancio on 2016-04-27.
//  Copyright © 2016 Graham Pancio. All rights reserved.
//

import Foundation

import Alamofire
import AlamofireObjectMapper

public protocol GetStylesDelegate: class {
    func retrievedStyleSet(styleSet: VehicleStyleSet)
    func getStyleSetFailed()
}

/**
 Retrieves vehicle styles using the Edmunds Vehicle API.
 
 A vehicle style identifies a vehicle more precisely than year, make and model.
 An example of a style name is: "LE Plus 4dr Sedan (1.8L 4cyl CVT)".
 Thus the vehicle style gives more information on the vehicle such as:
 - Number of doors
 - Category (submodel) of vehicle (eg. "Sedan")
 - The set of colors the vehicle of that style is available in.
 - And more.
 */
public class GetStyles {
    public weak var delegate: GetStylesDelegate?
    
    var apiKey: String
    
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    public func makeRequest(year: String, make: String, model: String) {
        Alamofire.request(Method.GET, formatUrl(year, make: make, model: model)).validate().responseObject { (response: Response<VehicleStyleSet, NSError>) in
            let vss = response.result.value
            
            if vss != nil && vss?.styles != nil && vss?.styles?.count > 0 {
                self.delegate?.retrievedStyleSet(vss!)
            } else {
                self.delegate?.getStyleSetFailed()
            }
        }
    }
    
    private func formatUrl(year: String, make: String, model: String) -> String {
        let urlString = String(format: "https://api.edmunds.com/api/vehicle/v2/%@/%@/%@/styles?view=full&fmt=json&api_key=%@", make, model, year, apiKey)
        return urlString
    }
    
}