//
//  UtilityExtensions.swift
//  MobileCore
//
//  Created by Michael Thornton on 8/29/19.
//  Copyright © 2019 Michael Thornton. All rights reserved.
//

import Foundation
import WebKit



public extension Array {
    
    func isValidIndex(_ index: Int) -> Bool {
        return index >= 0 && index < self.count
    }
} // end extension



extension WKWebView {
    func load(_ request: URLRequest, with cookies: [HTTPCookie]) {
        var request = request
        let headers = HTTPCookie.requestHeaderFields(with: cookies)
        for (name, value) in headers {
            request.addValue(value, forHTTPHeaderField: name)
        }

        load(request)
    }
}



extension URLRequest {
  
    /**
     Returns a cURL command representation of this URL request.
     */
    public var curlString: String {
        guard let url = url else { return "" }
        var baseCommand = "curl \(url.absoluteString)"
        
        if httpMethod == "HEAD" {
            baseCommand += " --head"
        }
        
        var command = [baseCommand]
        
        if let method = httpMethod, method != "GET" && method != "HEAD" {
            command.append("-X \(method)")
        }

        if let headers = allHTTPHeaderFields {
            for (key, value) in headers { //where key != "Cookie" {
                command.append("-H '\(key): \(value)'")
            }
        }
        
        if let data = httpBody, let body = String(data: data, encoding: .utf8) {
            command.append("-d '\(body)'")
        }
        
        return command.joined(separator: " \\\n\t")
    }
    
    init?(curlString: String) {
        return nil
    }
    
} // end extension



extension Date {
    
    
    func tomorrow() -> Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
    
    func yesterday() -> Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }

    
    func todayMidnight() -> Date {
        
        let date = Date()
        let components = Calendar.current.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year], from: date)
    
        return Calendar.current.date(from: components)!
    }
    
    
    func stringForFormat(_ format: String) -> String {

        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
} // end extension



public extension String {
        func fromBase64() -> String? {
                guard let data = Data(base64Encoded: self) else {
                        return nil
                }
                return String(data: data, encoding: .utf8)
        }
        func toBase64() -> String {
                return Data(self.utf8).base64EncodedString()
        }
    
} //end extension



extension Bundle {

    // Name of the app - title under the icon.
    var displayName: String? {
            return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ??
                object(forInfoDictionaryKey: "CFBundleName") as? String
    }
    
} // end extension



extension Data {
    
    func toString() -> String {
        return String(decoding: self, as: UTF8.self)
    }
} // end extension
