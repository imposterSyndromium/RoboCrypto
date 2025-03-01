//
//  HomeView.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-01.
//

import SwiftUI

struct HomeView: View {
    @State private var showPortfolio: Bool = false
    
    var body: some View {
        ZStack {
            // Background Layer
            Color.theme.background
                .ignoresSafeArea()
            
            // Content Layer
            VStack {
                HStack {
                    CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                        .background(showPortfolio ? CircleButtonAnimationView(animate: $showPortfolio) : nil)
                            
                            
                        
                    
                    Spacer()
                    
                    Text(showPortfolio ? "Portfolio" : "Live Prices")
                        .font(.headline)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.theme.accent)
                        .contentTransition(.numericText())
                    
                    Spacer()
                    
                    CircleButtonView(iconName: "chevron.right")
                        .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                        .onTapGesture {
                            withAnimation(.spring()) {
                                showPortfolio.toggle()
                            }
                        }
                        
                }
                .padding(.horizontal)
                
                
                Spacer(minLength: 0)
                
            }

        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
   
}
