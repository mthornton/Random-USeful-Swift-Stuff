//
//  LogService.swift
//  MobileCore
//
//  Created by Michael Thornton on 6/15/20.
//  Copyright © 2020 Michael Thornton. All rights reserved.
//

import Foundation



public protocol LogService {
    func Log(_ message: String, datetime: String, filename: String, function: String, line: Int)
} // end protocol

