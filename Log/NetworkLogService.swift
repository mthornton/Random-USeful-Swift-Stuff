//
//  NetworkLogService.swift
//  MobileCore
//
//  Created by Michael Thornton on 6/15/20.
//  Copyright © 2020 Michael Thornton. All rights reserved.
//

import Foundation
import AdSupport



public class NetworkLogService: LogService {
    

    private let network = SafeNetwork()
    private let logURL: URL
    
    
    public  init(url: URL) {
        self.logURL = url
    }
    
    
    
    public func Log(_ message: String, datetime: String, filename: String = #file, function: String = #function, line: Int = #line) {

        //need a way to know all the message came from the save device
        let id = UIDevice.current.identifierForVendor?.uuidString ?? "no device id"
        
        
        var urlRequest = URLRequest(url: self.logURL)
        urlRequest.httpMethod = "POST"
        

        let dataFields: [String: Any] = ["id" : id, "message": message, "datetime": datetime, "class": filename, "function": function, "line": line]
        
        do {
            let fields = try JSONSerialization.data(withJSONObject: dataFields, options: [])
            urlRequest.httpBody = fields
        } catch { }
        
        //API key
        urlRequest.setValue("KDzR4bGnJR8JYKSjVGf2dayHZ1liAyNf7lz7iSlO", forHTTPHeaderField: "x-api-key")

        

        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: urlRequest) { (data, urlResponse, error) in
            
            #if DEBUG
            if let error = error {
                print("error with network login \(error.localizedDescription)")
            }
            #endif
        }
        
        task.resume()
    }
    
} // end class
