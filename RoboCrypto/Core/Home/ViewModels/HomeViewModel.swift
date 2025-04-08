//
//  HomeViewModel.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-18.
//

import Foundation
import Combine


class HomeViewModel: ObservableObject {
    @Published var statistics: [StatisticModel] = []
    
    // Models
    @Published var searchText: String = "" //<-- connected to search bar
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    // Services
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    var cancellables = Set<AnyCancellable>()
    
    
    init() {
        addSubscribers()
    }
    
    
    func addSubscribers() {

        /// Search Bar Text  and allCoin Subscriber
        $searchText
            // combine the searchText with the allCoins array to filter the results
            .combineLatest(coinDataService.$allCoins)
            // debounce the search text to avoid unnecessary API calls - like when the user is typing - its a wait delay
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            // filter the coins based on the search text
            .map(filterCoins)
            // assign the filtered coins to the allCoins array
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            // store the subscriber in the cancellables set
            .store(in: &cancellables)
        
        
        /// updates market data statistics
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
            }
            .store(in: &cancellables)
        
        // updates portfolio coins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map { (coinModels, portfolioEntities) -> [CoinModel] in
                // loop through the coins and check if they are in the portfolio
                coinModels.compactMap { coin -> CoinModel? in
                    guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                        return nil
                    }
                    return coin.updateHoldings(amount: entity.amount)
                }
            }
            .sink { [weak self] (returnedCoins) in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
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
    
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        
        guard let data = marketDataModel else { return stats }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00", percentageChange: 0)
        
        stats.append(contentsOf: [marketCap, volume, btcDominance, portfolio])
        return stats

    }
}
