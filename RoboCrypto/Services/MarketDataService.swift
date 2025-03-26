//
//  MarketDataService.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-25.
//

import Foundation
import Combine


class MarketDataService {
    
    @Published var marketData: MarketDataModel? = nil
    var marketDataSubscription: AnyCancellable?
    
    init() {
        getData()
    }
    
    ///  Fetches all coins from the CoinGecko API
    ///  - Note: The API is paginated, so we're only fetching the first page of 250 coins
    private func getData() {
        let webAPI = "https://api.coingecko.com/api/v3/global"
        
        guard let url = URL(string: webAPI) else {
            print("Error: Invalid URL")
            return
        }
        
        marketDataSubscription = NetworkingManager.download(url: url)
            // decode the JSON data into CoinModel
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            // sink is used to handle the completion and the value of the subscription
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedGlobalData in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscription?.cancel()
            })
        
           
            
    }
}

