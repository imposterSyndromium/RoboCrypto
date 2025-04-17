//
//  SettingsView.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-04-14.
//


import SwiftUI

struct SettingsView: View {
    
    let defaultURL = URL(string: "https://www.google.com")!
    let githubPagesURL = URL(string: "https://impostersyndromium.github.io")!
//    let coffeeURL = URL(string: "https://www.buymeacoffee.com/nicksarno")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    let personalURL = URL(string: "https://impostersyndromium.github.io")!
    let githubSourceRepoURL = URL(string: "https://github.com/imposterSyndromium/RoboCrypto")!
    let swiftfulThinkingURL = URL(string: "https://www.swiftful-thinking.com")!
    let hackingWithSwiftURL = URL(string: "https://www.hackingwithswift.com")!
    
    var body: some View {
        NavigationStack {
            ZStack {
                // background
                Color.theme.background
                    .ignoresSafeArea()
                
                // content
                List {
                    applicationOutlineSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    coinGeckoSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    developerSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    applicationSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                }
            }
            .font(.headline)
            .accentColor(.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButtonView()
                        .padding(.top, 10)
                }
            }
        }
    }
}






#Preview {
    SettingsView()
}



extension SettingsView {
    
    private var applicationOutlineSection: some View {
        Section(header: Text("RoboCrypto")) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This application is a cryptocurrency market ticker tracker that allows you to view the latest prices and trends in the cryptocurrency market. It provides real-time data and a user-friendly interface for tracking your favourite coins.  This application also allows you to add coins to your portfolio calculator and track their performance over time.  This application  is not affiliated with any cryptocurrency exchange or platform and is intended for informational purposes only.  The data provided in this application is sourced from CoinGecko, a leading cryptocurrency data provider.  This application was created by Robin O'Brien (GitHub: imposterSyndromium) by following the SwiftfulThinking course created by Nick Sarno.  This application uses a public API from CoinGecko to provide real-time data on cryptocurrency prices, market capitalization, and other relevant information.  The data provided in this application is for informational purposes only and should not be considered as financial advice.  The developer of this application is not responsible for any losses or damages that may occur as a result of using this application or the data provided herein.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            
            Link("Visit Developer Website", destination: githubPagesURL)

        }
    }
    
    private var coinGeckoSection: some View {
        Section(header: Text("CoinGecko")) {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("The data provided in this application is sourced from CoinGecko, a leading cryptocurrency data provider.  This application uses a public API from CoinGecko to provide real-time data on cryptocurrency prices, market capitalization, and other relevant information.  The data provided in this application is for informational purposes only and should not be considered as financial advice.  The developer of this application is not responsible for any losses or damages that may occur as a result of using this application or the data provided herein.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Visit CoinGecko 🦎", destination: coingeckoURL)
        }
    }
    
    private var developerSection: some View {
        Section(header: Text("Developer")) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app uses SwiftUI and is written 100% in Swift. The project benefits from multi-threading, publishers/subscribers, and data persistance. The application uses MVVM architecture and is designed to be modular and reusable.  The application is built using the latest version of SwiftUI and is compatible with iOS 16.0 and later.  The application is designed to be user-friendly and easy to navigate, with a clean and modern interface.  The application is open source and the code is available on GitHub.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("View Source Code on GitHub", destination: githubSourceRepoURL)
        }
    }
    
    private var applicationSection: some View {
        Section(header: Text("Application")) {
            Link("Terms of Service", destination: githubPagesURL)
            Link("Privacy Policy", destination: githubPagesURL)
            Link("Company Website", destination: githubPagesURL)
            Link("Learn Swift/SwiftUI with Swiftful Thinking", destination: swiftfulThinkingURL)
            Link("Learn Swift/SwiftUI with Hacking With Swift", destination: hackingWithSwiftURL)
        }
    }
    
    
}
