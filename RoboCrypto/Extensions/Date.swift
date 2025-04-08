//
//  Date.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-26.
//

import Foundation


extension Date {
    
    func currentDateWithMilliseconds() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        return formatter.string(from: Date())
    }
    
    
}
