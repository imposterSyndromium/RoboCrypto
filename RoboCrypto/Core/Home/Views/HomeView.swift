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
                header
                
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



extension HomeView {
    private var header: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .background(showPortfolio ? CircleButtonAnimationView() : nil)
            
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
                        withAnimation(.easeOut(duration: 0.3)) {
                            showPortfolio.toggle()
                        }
                }
                
        }
        .padding(.horizontal)
    }
}
