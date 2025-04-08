//
//  CircleButtonAnimationView.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-01.
//

import SwiftUI


///  CircleButtonAnimationView is a view that animates a stroke effect coming from a circle.
///  The CircleButtonAnimationView is used to draw a user's eyes to a change of state in a button.
///  There is a delay before this animation starts which is initiated by the onAppear modifier's use of DispatchQueue.
struct CircleButtonAnimationView: View {
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        Circle()
            .stroke(Color.accentColor, lineWidth: animationAmount == 1 ? 0 : 5)
            .scaleEffect(animationAmount * 0.9)
            .opacity(2 - animationAmount)
            //.animation(.easeOut(duration: 0.8), value: animationAmount)
            .onAppear {
                // set a delay before starting the animation
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    withAnimation(.easeOut(duration: 1.2)) {
                        animationAmount = 2
                    }
                }
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
