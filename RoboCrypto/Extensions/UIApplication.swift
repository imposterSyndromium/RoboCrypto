//
//  UIApplication.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-20.
//


import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
