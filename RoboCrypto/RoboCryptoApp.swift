//
//  RoboCryptoApp.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-01.
//

import SwiftUI

@main
struct RoboCryptoApp: App {
    // create instance of HomeViewModel to inject into the environment
    @StateObject private var vm = HomeViewModel()
    @State private var showLaunchView: Bool = true
    
    // make nav bar title text color match accent color
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }
    
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                HomeView()
                    .environmentObject(vm)
                
                
                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2)
                    
            }

        }
    }
}
