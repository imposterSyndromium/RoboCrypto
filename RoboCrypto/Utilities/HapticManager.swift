//
//  HapticManager.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-04-11.
//

import Foundation
import SwiftUI


class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
