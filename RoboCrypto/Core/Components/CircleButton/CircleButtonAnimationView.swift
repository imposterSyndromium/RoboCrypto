//
//  CircleButtonAnimationView.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-01.
//

import SwiftUI

struct CircleButtonAnimationView: View {

     @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        Circle()
            .stroke(Color.accentColor, lineWidth: 5)
            .scaleEffect(animationAmount * 0.7)
            .opacity(2 - animationAmount)
            .animation(
                .easeOut(duration: 0.4),
                value: animationAmount
            )
            .onAppear {
                animationAmount = 2
            }
    }
    
}

struct CircleButtonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnimationView()
            .foregroundColor(.red)
            .frame(width: 70, height: 70)
    }
}
