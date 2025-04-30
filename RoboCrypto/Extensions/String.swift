
//
//  String.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-20.
//

import Foundation

extension String {
    /// A Boolean value indicating whether the string is empty or contains only whitespace and newline characters.
    ///
    /// This property trims all leading and trailing whitespace and newline characters from the string,
    /// then checks if the resulting string is empty.
    ///
    /// - Returns: `true` if the string is empty or contains only whitespace and newlines; otherwise, `false`.
    var isReallyEmpty: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    /// A new string made by removing all HTML tag occurrences from the original string.
    ///
    /// This property uses a regular expression to remove any substring that matches an HTML tag pattern,
    /// i.e., anything between `<` and `>`.
    ///
    /// - Returns: A string with all HTML tags removed.
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
