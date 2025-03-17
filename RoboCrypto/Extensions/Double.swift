//
//  Double.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-17.
//

import Foundation

/// currency formatter
extension Double {
    
    
    ///
    ///  Currency Formatter
    ///  - Returns: NumberFormatter
    ///  - Note:  NumberFormatter for currency
    ///
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        //formatter.locale = Locale.current
        //formatter.currencySymbol = "cad"
        //formatter.currencySymbol = "$"
        
        return formatter
    }
    
    
    ///  asCurrencyWithDecimals
    ///  - Returns: String
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    ///
    ///  Currency Formatter
    ///  - Returns: NumberFormatter
    ///  - Note:  NumberFormatter for currency
    ///
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        //formatter.locale = Locale.current
        //formatter.currencySymbol = "cad"
        //formatter.currencySymbol = "$"
        
        return formatter
    }
    
    
    ///  asCurrencyWithDecimals
    ///  - Returns: String
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    
    
    ///  this converts a double to a string with 2 decimal places
    /// - Returns:  String
    ///
    /// - Note:  this converts a double to a string with 2 decimal places
    /// - Example:  1.2345 -> "1.23"
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
}

