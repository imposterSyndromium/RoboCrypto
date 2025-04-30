//
//  LaunchScreen.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-04-15.
//

import SwiftUI

struct LaunchView: View {
    @Binding var showLaunchView: Bool
    @State private var showLoadingText: Bool = false
    @State private var loops: Int = 0
    
    let timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()
    @State private var count: Int = 0
    
    var body: some View {
        ZStack {
            
            // background
            ZStack {
                Color.launch.background
                    .ignoresSafeArea()
                
                Image(.logoTransparent)
                    .resizable()
                    .frame(width:100, height:100)
            }
            
            // content
            if showLoadingText {
                ZStack {
                    
                    // text
                    Text("Loading crypto coins & portfolio...")
                        .font(.headline)
                        .fontWeight(.heavy)
                        .offset(y: 70)
                    
                    // bouncing dots animation
                    HStack {
                        Circle()
                            .offset(y: count == 1 ? -10 : 0)
                        Circle()
                            .offset(y: count == 2 ? -10 : 0)
                        Circle()
                            .offset(y: count == 3 ? -10 : 0)
                    }
                    .offset(y: 120)
                    .frame(width: 70)
                    
                    
                }
                .foregroundStyle(Color.launchAccent)
                .transition(AnyTransition.scale.animation(
                    .smooth(duration: 0.4, extraBounce: 0.6)
                ))
                
            }
        }
        .onAppear {
            showLoadingText.toggle()
        }
        .onTapGesture {
            if loops >= 1 {
                withAnimation {
                    showLaunchView = false
                }
            }
        }
        .onReceive(timer) { _ in
            withAnimation(.easeInOut(duration: 0.5)) {
                calculateLoops()
            }
        }
        
        
    }
    
    
    func calculateLoops() {
        if count == 3 {
            count = 0
            loops += 1
            if loops >= 3 {
                showLaunchView = false
            }
        } else {
            count += 1
        }
    }
    
}

#Preview {
    LaunchView(showLaunchView: .constant(true))
        
}
