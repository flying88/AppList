//
//  InformationConnector.swift
//  AppLists
//
//  Created by 이 동준 on 2016. 6. 7..
//  Copyright © 2016년 이 동준. All rights reserved.
//

import UIKit
import Alamofire

//    "https://itunes.apple.com/search?term=topfree&country=kr&entity=software"



protocol InformationConnectorProtocol {
    func completeLoadInformation(result: NSArray?, data: NSData?, error: ErrorType?)
    func loadError()
}


class InformationConnector: NSObject {
    
    var type: String?
    var delegate: LaunchScreenViewController?
    
    init(type: String) {
        super.init()
        
        self.type = type
    }
    
    required init(type: String, delegate: LaunchScreenViewController) {
        super.init()
        
        self.type = type
        self.delegate = delegate
    }

    
    internal func start() {
        NSLog("Start get app information")
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        Alamofire.request(
            .GET,
            "https://itunes.apple.com/search?term=\(self.type!)&country=kr&entity=software&limit=1",
            parameters: nil,
            encoding: .JSON).responseJSON(completionHandler: {
                (connectionRequest, connectionResponse, connectionResult) in
                
                NSLog("connectionRequest : \(connectionRequest!)")
                NSLog("connectionResponse : \(connectionResponse!)")
                NSLog("connectionResult : \(connectionResult)")
                
                switch connectionResult {
                    
                case .Success(let JSON):
                    
                    let jsonResult: NSArray = JSON["results"] as! NSArray
                    self.delegate?.completeLoadInformation(jsonResult, data: nil, error: nil)
                     break
                    
                case .Failure(let data, let responseError):
                    let dataString: NSString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                    NSLog("data : \(dataString)")
                    NSLog("error : \(responseError)")
                    self.delegate?.completeLoadInformation(nil, data: data, error: responseError)
                    
                    break
                }
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
        
        NSLog("End get app information")
    }
}
