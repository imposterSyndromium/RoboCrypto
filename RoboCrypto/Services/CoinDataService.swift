//
//  CoinDataService.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-18.
//

import Foundation
import Combine


class CoinDataService {
    
    @Published var allCoins: [CoinModel] = []
    var coinSubscription: AnyCancellable?    
    
    init() {
        getCoins()
    }
    
    ///  Fetches all coins from the CoinGecko API
    ///  - Note: The API is paginated, so we're only fetching the first page of 250 coins
    private func getCoins() {
        let webAPI = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=cad&order=market_cap_dsc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
        
        guard let url = URL(string: webAPI) else {
            print("Error: Invalid URL")
            return
        }
        
        coinSubscription = NetworkingManager.download(url: url)
            // decode the JSON data into CoinModel
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            // sink is used to handle the completion and the value of the subscription
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
           
            
    }
}




