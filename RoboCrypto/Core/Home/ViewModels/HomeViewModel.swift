//
//  HomeViewModel.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-18.
//

import Foundation
import Combine


class HomeViewModel: ObservableObject {
    @Published var statistics: [StatisticModel] = [
        StatisticModel(title: "Title", value: "100,000", percentageChange: 2.5),
        StatisticModel(title: "Title", value: "100,000"),
        StatisticModel(title: "Title", value: "100,000"),
        StatisticModel(title: "Title", value: "100,000", percentageChange: -0.6)
    ]
    
    @Published var searchText: String = "" //<-- connected to search bar
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    private let dataService = CoinDataService()
    var cancellables = Set<AnyCancellable>()
    
    
    init() {
        addSubscribers()
    }
    
    
    func addSubscribers() {

        /// Search Bar Text  and allCoin Subscriber
        $searchText
            // combine the searchText with the allCoins array to filter the results
            .combineLatest(dataService.$allCoins)
            // debounce the search text to avoid unnecessary API calls - like when the user is typing - its a wait delay
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            // filter the coins based on the search text
            .map(filterCoins)
        //            .map { text, startingCoins -> [CoinModel] in
        //                guard !text.isReallyEmpty else {
        //                    return startingCoins
        //                }
        //
        //                // return coins that contain the text in the name, symbol, or id
        //                let lowercasedText = text.lowercased()
        //                return startingCoins.filter { coin -> Bool in
        //                    coin.name.lowercased().contains(lowercasedText) ||
        //                    coin.symbol.lowercased().contains(lowercasedText) ||
        //                    coin.id.lowercased().contains(lowercasedText)
        //                }
        //
        //            }
            // assign the filtered coins to the allCoins array
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            // store the subscriber in the cancellables set
            .store(in: &cancellables)
        
    }
    
    private func filterCoins (serchBarText: String, coins: [CoinModel]) -> [CoinModel] {
        guard !serchBarText.isReallyEmpty else {
            return coins
        }
        
        // return coins that contain the text in the name, symbol, or id
        let lowercasedText = serchBarText.lowercased()
        return coins.filter { coin -> Bool in
            coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
}
