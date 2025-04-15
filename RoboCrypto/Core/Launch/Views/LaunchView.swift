//
//  LaunchScreen.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-04-15.
//

import SwiftUI

struct LaunchView: View {
    @State private var loadingText: [String] = "Loading crypto coins & portfolio...".map { String($0) }
    @State private var showLoadingText: Bool = false
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    @Binding var showLaunchView: Bool
    
    var body: some View {
        
        ZStack {
            
            Color.launch.background
                .ignoresSafeArea()
            
            Image(.logoTransparent)
                .resizable()
                .frame(width:100, height:100)
            
            
            ZStack {
                if showLoadingText {

                    HStack(spacing: 0) {
                        ForEach(loadingText.indices) { index in
                            Text(loadingText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.launch.accent)
                                .offset(y: counter == index ? -5 : 0)
                        }
                    }
                    .transition(AnyTransition.scale.animation(
                        .smooth(duration: 0.4, extraBounce: 0.4)
                    ))
                    
                }
            }
            .offset(y: 70)
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
            withAnimation(.spring()) {
                
                let lastIndex = loadingText.count - 1
                if counter == lastIndex {
                   counter = 0
                    loops += 1
                    
                    if loops >= 1 {
                        showLaunchView = false
                    }
                } else {
                    counter += 1
                }
                
            }
        }
    }
}

#Preview {
    LaunchView(showLaunchView: .constant(true))
        
}
