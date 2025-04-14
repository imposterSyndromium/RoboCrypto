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
    
    
    
    // "2013-07-05T00:00:00.000Z"
    init(coinGeckoString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: coinGeckoString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    
    
    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }
    
    
    var asShortDateString: String {
        return shortFormatter.string(from: self)
    }
    
    
}
