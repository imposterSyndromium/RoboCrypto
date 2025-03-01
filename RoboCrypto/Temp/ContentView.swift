//
//  ContentView.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-01.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack {
                Text("Accent Color")
                    .foregroundColor(Color.theme.accent)
                
                Text("Secondary text Color")
                    .foregroundColor(Color.theme.secondaryText)
                
                Text("Green Color")
                    .foregroundColor(Color.theme.greenColor)
                
                Text("Red Color")
                    .foregroundColor(Color.theme.redColor)
            }
        }
    }
}

#Preview {
    ContentView()
}
