//
//  HomeViewModel.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-18.
//

import Foundation
import Combine


class HomeViewModel: ObservableObject {
    @Published var searchText: String = "" //<-- connected to search bar
    
    // Models
    @Published var statistics: [StatisticModel] = []
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    @Published var isLoading: Bool = false
    @Published var sortOption: SortOption = .holdings
    
    // Services
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    // sorting
    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    
    
    init() {
        addSubscribers()
    }
    
    
    func addSubscribers() {

        /// Search Bar Text  and allCoin Subscriber
        $searchText
            // combine the searchText with the allCoins array to filter the results
            .combineLatest(coinDataService.$allCoins, $sortOption)
            // debounce the search text to avoid unnecessary API calls - like when the user is typing - its a wait delay
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            // filter the coins based on the search text
            .map(filterAndSortCoins)
            // assign the filtered coins to the allCoins array
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            // store the subscriber in the cancellables set
            .store(in: &cancellables)
        
        
        // updates portfolio coins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] (returnedCoins) in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)
        
        
        /// updates market data statistics
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellables)

    }
    
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
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
    
    
    private func filterAndSortCoins (text: String, coins: [CoinModel], sort: SortOption) -> [CoinModel] {
        var updatedCoins = filterCoins(serchBarText: text, coins: coins)
        sortCoins(sort: sort, coins: &updatedCoins)
        
        return updatedCoins
    }
    
    
    private func sortCoins(sort: SortOption, coins: inout [CoinModel]) {
        // inout allows us to modify the coins array directly using sort method and return that array (same array in as out)
        switch sort {
            case .rank, .holdings:
                coins.sort(by: { $0.rank < $1.rank })
            case .rankReversed, .holdingsReversed:
                coins.sort(by: { $0.rank > $1.rank })
            case .price:
                coins.sort(by: { $0.currentPrice > $1.currentPrice })
            case .priceReversed:
                coins.sort(by: { $0.currentPrice < $1.currentPrice })
           
        }
    }
    
    
    private func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        switch sortOption {
            case .holdings:
                return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
            case .holdingsReversed:
                return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
            default:
                return coins
        }
        
    }
    
    
    private func mapAllCoinsToPortfolioCoins(allCoins: [CoinModel], portfolioEntity: [PortfolioEntity]) -> [CoinModel] {
        allCoins.compactMap { coin -> CoinModel? in
            guard let entity = portfolioEntity.first(where: { $0.coinID == coin.id }) else {
                return nil
            }
            return coin.updateHoldings(amount: entity.amount)
        }
    }
    
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        
        guard let data = marketDataModel else { return stats }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
       
        let portfolioValue = portfolioCoins.map({ $0.currentHoldingsValue }).reduce(0, +)
        let previousValue = portfolioCoins.map { coin -> Double in
            let currentValue = coin.currentHoldingsValue
            let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
            let previousValue = currentValue / (1 + percentChange)
            return previousValue
        }
        .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue)
        
        let portfolio = StatisticModel(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange: percentageChange)
        
        stats.append(contentsOf: [marketCap, volume, btcDominance, portfolio])
        return stats

    }
}
