//
//  FileLogService.swift
//  MobileCore
//
//  Created by Michael Thornton on 6/15/20.
//  Copyright © 2020 Michael Thornton. All rights reserved.
//

import Foundation



public class FileLogService: LogService {
    
    
    private var filePath: String
    private var queue: DispatchQueue
    
    private var _fileHandle: FileHandle?
    
    private var fileHandle: FileHandle? {
        
        if _fileHandle == nil {
            
            if !FileManager.default.fileExists(atPath: filePath) {
                FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil)
            }
            _fileHandle = FileHandle(forWritingAtPath: filePath)
        }
        
        return _fileHandle
    }
    
    

    init(filePath: String) {
        self.filePath = filePath
        self.queue = DispatchQueue(label: "File Log Service")
    }
    
    
    deinit {
        _fileHandle?.closeFile()
    }

    
    public func Log(_ message: String, datetime: String, filename: String = #file, function: String = #function, line: Int = #line) {
        
        queue.sync {
            
            if let file = self.fileHandle {
                if let data = "\(datetime) : \(filename)) : \(function) : \(line) \n \(message) \n\n".data(using: .utf8) {
                    file.seekToEndOfFile()
                    file.write(data)
                }
            }
        }
        
    }
    
    
} // end class
