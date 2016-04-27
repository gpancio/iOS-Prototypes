//
//  ViewController.swift
//  EdmundsAPI
//
//  Created by Graham Pancio on 04/27/2016.
//  Copyright (c) 2016 Graham Pancio. All rights reserved.
//

import UIKit
import EdmundsAPI

class ViewController: UIViewController, GetMakesDelegate, GetModelsDelegate {
    
    let apiKey = "32hj79x57h9s2w6fcjane5at"

    @IBAction func getMakes(sender: AnyObject) {
        let svc = GetMakes(apiKey: apiKey)
        svc.delegate = self
        svc.makeRequest("2012")
    }
    
    @IBAction func getModels(sender: AnyObject) {
        let svc = GetModels(apiKey: apiKey)
        svc.delegate = self
        svc.makeRequest("2012", make: "Honda")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func onSuccess(makes: [String]) {
        print("Got makes: \(makes)")
    }
    
    func onFail() {
        print("failed")
    }

}

