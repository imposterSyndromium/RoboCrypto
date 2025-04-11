//
//  PortfolioView.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-26.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    
                    coinLogoList
                    
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                }
            }
            .navigationTitle("Edit Portfolio").navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButtonView()
                        .padding(.top, 10)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingNavBarButton
                }
            }
            .onChange(of: vm.searchText) { _, newValue in
                if newValue == "" {
                    removeSelectedCoin()
                }
            }
        }
    }
}



#Preview {
    PortfolioView()
        .environmentObject(HomeViewModel())
}




// MARK: - PortfolioView Extensions
extension PortfolioView {
    
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
                    CoinLogoCardView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                selectedCoin = coin
                                updateSelectedCoin(coin: coin)
                            }
                            
                        }
                        .background(RoundedRectangle(cornerRadius: 10).stroke(selectedCoin?.id == coin.id ? Color.theme.greenColor : Color.clear, lineWidth: 1))
                        
                }
            }
            .padding(.vertical, 4)
            .padding(.leading)
        }
    }
    
    
    private func updateSelectedCoin(coin: CoinModel) {
        selectedCoin = coin
        if let portfolioCoin = vm.portfolioCoins.first(where: { $0.id == coin.id }),
           let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"            
        } else {
            quantityText = ""
        }
    }
    
    
    private var portfolioInputSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current ")
                +
                Text(selectedCoin?.symbol.uppercased() ?? "#err")
                    .fontWeight(.bold)
                +
                Text(" value:")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
                    .fontWeight(.bold)
                    
            }
            
            Divider()
            
            HStack {
                Text("Amount holding:")
                Spacer()
                TextField("ex: 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            
            Divider()
            
            HStack {
                Text("Current value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
                    .fontWeight(.bold)
            }
        }
        .padding()
        .padding(.trailing, 30)
    }
    
    
    private var trailingNavBarButton: some View {
        HStack {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1 : 0)

            Button {
                saveButtonPressed()
            } label: {
                Text("Save".uppercased())
            }
            .opacity(selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText) ? 1 : 0)

            
        }
        .font(.headline)
        .padding(.top, 6)

    }
    
    
    private func saveButtonPressed() {
        guard let coin = selectedCoin,
              let amount = Double(quantityText) else { return }
        
        // save to portfolio
        vm.updatePortfolio(coin: coin, amount: amount)
        
        // show checkmark
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedCoin()
        }
        
        // hide keyboard
        UIApplication.shared.endEditing()
        
        // hide checkmark after delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        }
        
    }
    
    
    private func removeSelectedCoin() {
        withAnimation(.easeOut) {
            selectedCoin = nil
            vm.searchText = ""
        }
    }
    
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
}
