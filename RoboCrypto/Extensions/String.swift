//
//  String.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-20.
//

import Foundation



extension String {
    var isReallyEmpty: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
