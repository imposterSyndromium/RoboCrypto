//
//  HomeView.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-01.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm: HomeViewModel
    
    @State private var showPortfolio: Bool = false
    @State private var showAddToPortfolioSheetView: Bool = false
    
    @State private var selectedCoin: CoinModel? = nil
    @State private var showDetailView: Bool = false
    @State private var showSettingsView: Bool = false
    
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                // Background Layer
                Color.theme.background
                    .ignoresSafeArea()
                    .sheet(isPresented: $showAddToPortfolioSheetView) {
                        PortfolioView()
                            .environmentObject(vm)
                    }
                
                // Content Layer
                VStack {
                    header
                    
                    HomeStatView(showPortfolio: $showPortfolio)
                    
                    SearchBarView(searchText: $vm.searchText)                    
                    
                    columnTitles
                    
                    if !showPortfolio {
                        allCoinsList
                            .transition(.move(edge: .leading))
                    } else {
                        portfolioCoinsList
                            .transition(.move(edge: .trailing))
                    }
                    
                    Spacer(minLength: 0)
                }
                .sheet(isPresented: $showSettingsView) {
                    SettingsView()
                }
            }
            .navigationDestination(isPresented: $showDetailView) {
                if let selectedCoin {
                    DetailView(coin: selectedCoin)
                } else {
                    ContentUnavailableView("There was an error getting data for a selectedCoin", image: "slash.circle")
                }
            }
        }
    }
}

#Preview {
    let vm = HomeViewModel()
    HomeView()
        .environmentObject(vm)
}



extension HomeView {
    
    private var header: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .background(showPortfolio ? CircleButtonAnimationView() : nil)
                .onTapGesture {
                    if showPortfolio {
                        showAddToPortfolioSheetView.toggle()
                    } else {
                        showSettingsView.toggle()
                    }
                }
            
            Spacer()
            
            VStack {                
                Text("RoboCrypto")
                    .padding(.bottom, 3)
                    .foregroundColor(Color.theme.accent)
                
                
                Text(showPortfolio ? "Your Portfolio" : "Live Prices")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.theme.accent)
                    .contentTransition(.numericText())
            }
            
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
    
    
    private var allCoinsList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        showCoinDetailView(coin: coin)
                    }
                
                
            }
        }
        .listStyle(PlainListStyle())
    }
    
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        showCoinDetailView(coin: coin)
                    }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    
    private func showCoinDetailView(coin: CoinModel) {
        selectedCoin = coin
        showDetailView.toggle()
    }
    
    
    private var columnTitles: some View {
        HStack {
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    // set visibility
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1 : 0)
                    // set rotation of chevron
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            
            Spacer()
            
            if showPortfolio {
                HStack(spacing: 4) {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1 : 0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                    
                    
                }
                .onTapGesture {
                    withAnimation {
                        vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
            }
            
            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1 : 0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
                
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            .onTapGesture {
                withAnimation {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            }
            
            Button {
                withAnimation(.linear(duration: 2.0)) {
                    vm.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0))
            
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
