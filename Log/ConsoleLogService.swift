//
//  ConsoleLogService.swift
//  MobileCore
//
//  Created by Michael Thornton on 6/15/20.
//  Copyright © 2020 Michael Thornton. All rights reserved.
//

import Foundation



public class ConsoleLogService: LogService {
    
    public func Log(_ message: String, datetime: String, filename: String = #file, function: String = #function, line: Int = #line) {
        print("\(datetime) : \(filename)) : \(function) : \(line) \n \(message) \n\n")
    }
} // end class
