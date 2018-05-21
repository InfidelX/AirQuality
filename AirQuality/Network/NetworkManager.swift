//
//  NetworkManager.swift
//  AirQuality
//
//  Created by Jovanco Jovanovski on 5/10/18.
//  Copyright © 2018 Jovanco Jovanovski. All rights reserved.
//

import Foundation

class NetworkManager: NSObject {
    
    struct APIEndPoints {
        let sensorsList = "https://skopjepulse.mk/rest/sensor"
        let data24 = "https://skopjepulse.mk/rest/data24h"
    }
    
    let API = APIEndPoints()
    let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: OperationQueue.main)

    func loadDataFor(urlString: String, withCompletion completion: @escaping (_ resourceData : [AnyObject]?) -> Void) {
        let url = URL(string: urlString)!
        let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let data = data else {
                completion(nil)
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [AnyObject] else {
                completion(nil)
                return
            }
            completion(json)
        })
        task.resume()
    }
}
