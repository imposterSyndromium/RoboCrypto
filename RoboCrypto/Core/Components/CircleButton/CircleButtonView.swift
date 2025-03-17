//
//  CircleButtonView.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-01.
//

import SwiftUI

struct CircleButtonView: View {
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .fill(Color.theme.background)
            )
            .shadow(color: Color.theme.accent.opacity(0.45), radius: 10, x: 0.0, y: 0.0)
            .padding()
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Group {
        CircleButtonView(iconName: "info")
            .padding()
        
        CircleButtonView(iconName: "plus")
            .padding()
            .colorScheme(.dark)
            .background(Color.theme.accent)
            .colorScheme(.dark)
    }
       
}
