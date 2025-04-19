//
//  SettingsView.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-04-14.
//


import SwiftUI

struct SettingsView: View {
    
    // section less/more controllers
    @State private var showFullAppOutline: Bool = false
    @State private var showFullCoinGecko: Bool = false
    @State private var showFullDeveloper: Bool = false
    @State private var showFullDisclaimer: Bool = false
    
    let defaultURL = URL(string: "https://www.google.com")!
    let githubPagesURL = URL(string: "https://impostersyndromium.github.io")!
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
                    Group {
                        applicationOutlineSection
                        coinGeckoSection
                        developerSection
                        disclaimerSection
                        linksSection
                    }
                    .listRowBackground(Color.theme.background.opacity(0.5))
                }
            }
            .font(.headline)
            .accentColor(.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle("Information")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButtonView()
                        .padding(.trailing, 10)
                       
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
        Section {
            VStack(alignment: .leading) {
                Text("Application")
                    .font(.title3).bold()
                
                Divider()
                
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.vertical, 4)
                
                Text("""
                     This application was created by Robin O'Brien (GitHub: imposterSyndromium) by following the SwiftfulThinking course created by Nick Sarno.
                      
                     This application provides the following:
                      
                     - a cryptocurrency market ticker tracker that allows you to view the latest prices and trends in the cryptocurrency market. It provides real-time data and a user-friendly interface for tracking your favourite coins.    
                      
                     - allows you to add coins to your portfolio calculator and track their performance over time.      
                      
                     - data provided in this application is sourced from CoinGecko, a leading cryptocurrency data provider; uses a public API from CoinGecko to provide real-time data on cryptocurrency prices, market capitalization, and other relevant information. 
                    """)
                    .lineLimit(showFullAppOutline ? nil : 4)
                    .font(.callout)
                    .foregroundStyle(Color.theme.accent)
                
                Button {
                    withAnimation(.easeInOut) {
                        showFullAppOutline.toggle()
                    }
                } label: {
                    Text(showFullAppOutline ? "less..." : "Read more...")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.vertical, 4)
                }

            }
            .padding(.vertical)
            
            Link("Visit Developer Website", destination: githubPagesURL)

        }
    }
    
    
    private var coinGeckoSection: some View {
        Section {
            VStack(alignment: .leading) {
                Text("CoinGecko.com")
                    .font(.title3).bold()
                
                Divider()
                
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.vertical, 4)
                
                Text("The data provided in this application is sourced from CoinGecko, a leading cryptocurrency data provider.  This application uses a public API from CoinGecko to provide real-time data on cryptocurrency prices, market capitalization, and other relevant information.  The data provided in this application is for informational purposes only and should not be considered as financial advice.  The developer of this application is not responsible for any losses or damages that may occur as a result of using this application or the data provided herein.")
                    .lineLimit(showFullCoinGecko ? nil : 4)
                    .font(.callout)
                    .foregroundStyle(Color.theme.accent)
                
                Button {
                    withAnimation {
                        showFullCoinGecko.toggle()
                    }
                } label: {
                    Text(showFullCoinGecko ? "less..." : "Read more...")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.vertical, 4)
                }
            }
            .padding(.vertical)
            Link("Visit CoinGecko.com 🦎", destination: coingeckoURL)
        }
    }
    
    
    private var developerSection: some View {
        Section {
            VStack(alignment: .leading) {
                Text("Developer: GitHub.imposterSyndromium")
                    .font(.title3).bold()
                
                Divider()
                
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.vertical, 4)
                
                Text("""
                     Application points:
                     
                     - Uses SwiftUI and is written 100% in Swift
                     - Optimized for iPhone and iPad
                     - Multi-threading
                     - Dependancy injection
                     - Publishers/subscribers using Combine framework
                     - Data persistence using Core Data
                     - MVVM architecture
                     - Is modular and reusable
                     - Works with iOS 16.0 and above
                     - User friendly and easy to navigate
                     - Clean and modern interface
                     - Open source and available on GitHub
                     
                     """)
                    .lineLimit(showFullDeveloper ? nil : 4)
                    .font(.callout)
                    .foregroundStyle(Color.theme.accent)
                
                Button {
                    withAnimation(.easeInOut) {
                        showFullDeveloper.toggle()
                    }
                } label: {
                    Text(showFullDeveloper ? "less..." : "Read more...")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.vertical, 4)
                }
            }
            .padding(.vertical)
            Link("View Source Code on GitHub", destination: githubSourceRepoURL)
        }
    }
    
    
    private var disclaimerSection: some View {
        Section {
            VStack(alignment: .leading) {
                Text("Disclaimer")
                    .font(.title3).bold()
                
                Divider()
                
                Image(systemName: "shield.lefthalf.filled")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color.theme.accent)
                    .frame(height: 75)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.vertical, 4)
                
                Text("This application  is not affiliated with any cryptocurrency exchange or platform and is intended for informational purposes only.  The data provided in this application is for informational purposes only and should not be considered as financial advice.  The developer of this application is not responsible for any losses or damages that may occur as a result of using this application or the data provided herein.")
                    .lineLimit(showFullDisclaimer ? nil : 4)
                    .font(.callout)
                    .foregroundStyle(Color.theme.accent)
                
                Button {
                    withAnimation(.easeInOut) {
                        showFullDisclaimer.toggle()
                    }
                } label: {
                    Text(showFullDisclaimer ? "less..." : "Read more...")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.vertical, 4)
                }
            }
            .padding(.vertical)
        }
    }
    
    
    private var linksSection: some View {
        Section(header: Text("Links")) {
            Link("Terms of Service", destination: githubPagesURL)
            Link("Privacy Policy", destination: githubPagesURL)
            Link("Company Website", destination: githubPagesURL)
            Link("Learn Swift/SwiftUI with Swiftful Thinking", destination: swiftfulThinkingURL)
            Link("Learn Swift/SwiftUI with Hacking With Swift", destination: hackingWithSwiftURL)
        }
    }
    
    
}
