//
//  HomeViewModel.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-18.
//

import Foundation
import Combine


class HomeViewModel: ObservableObject {
    
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    private let dataService = CoinDataService()
    var cancellables = Set<AnyCancellable>()
    
    
    init() {
        addSubscribers()
    }
    
    
    func addSubscribers() {
        dataService.$allCoins
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
}
