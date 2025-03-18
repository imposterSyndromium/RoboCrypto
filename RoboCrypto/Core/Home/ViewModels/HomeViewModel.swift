//
//  HomeViewModel.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-18.
//

import Foundation


class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            self.allCoins.append(CoinModel.sample)
            self.portfolioCoins.append(CoinModel.sample)
        }
    }
}
