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
    
    
    
    /// Convert a Double to a String with K, M, Bn, Tr abbreviations.
        /// ```
        /// Convert 12 to 12.00
        /// Convert 1234 to 1.23K
        /// Convert 123456 to 123.45k
        /// Convert 12345678 to 12.34m
        /// Convert 1234567890 to 1.23Bn
        /// Convert 123456789012 to 123.45Bn
        /// Convert 12345678901234 to 12.34Tr
        /// ```
        func formattedWithAbbreviations() -> String {
            let num = abs(Double(self))
            let sign = (self < 0) ? "-" : ""

            switch num {
            case 1_000_000_000_000...:
                let formatted = num / 1_000_000_000_000
                let stringFormatted = formatted.asNumberString()
                return "\(sign)\(stringFormatted)Tr"
            case 1_000_000_000...:
                let formatted = num / 1_000_000_000
                let stringFormatted = formatted.asNumberString()
                return "\(sign)\(stringFormatted)Bn"
            case 1_000_000...:
                let formatted = num / 1_000_000
                let stringFormatted = formatted.asNumberString()
                return "\(sign)\(stringFormatted)m"
            case 1_000...:
                let formatted = num / 1_000
                let stringFormatted = formatted.asNumberString()
                return "\(sign)\(stringFormatted)k"
            case 0...:
                return self.asNumberString()

            default:
                return "\(sign)\(self)"
            }
        }
}

