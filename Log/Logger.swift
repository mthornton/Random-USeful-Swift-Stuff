//
//  Log.swift
//  MobileCore
//
//  Created by Michael Thornton on 6/15/20.
//  Copyright © 2020 Michael Thornton. All rights reserved.
//

import Foundation



public func SafeLog(_ message: String) {
    Logger.shared.Log(message)
}



public class Logger {
    
    private var logServices = [LogService]()
    
    public static let shared = Logger()
    
    
    private init() {
    
        self.registerLogService(ConsoleLogService())
        
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent("DebugLogs.txt")
            print(fileURL.path)
            self.registerLogService(FileLogService(filePath: fileURL.path))
        }
        
        if let url = URL(string: "https://5vzro5br3e.execute-api.us-east-1.amazonaws.com/v1/log") {
            self.registerLogService(NetworkLogService(url: url))
        }
    }
    
    
    
    public func registerLogService(_ logService: LogService) {
        logServices.append(logService)
    }
    
    
    
    public func Log(_ message: String, filename: String = #file, line: Int = #line, function: String = #function) {

        #if DEBUG
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        
        for logService in logServices {
            logService.Log(message, datetime: Date().stringForFormat("MM/DD/YY HH:mm:ss"), filename: self.fileName(filePath: filename), function: function, line: line)
        }
        #endif
    }
    
    
    private func fileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
    
} // end class



