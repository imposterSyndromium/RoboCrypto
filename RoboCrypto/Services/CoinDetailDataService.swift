//
//  CoinDetailDataService.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-04-14.
//

import Combine
import Foundation




class CoinDetailDataService {
    
    @Published var coinDetails: CoinDetailModel? = nil
    
    var coinDetailSubscription: AnyCancellable?
    let coin: CoinModel
    
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinDetails()
    }

    
    func getCoinDetails() {
        // The URL for the CoinGecko API endpoint to fetch cryptocurrency data.
        let webAPI = "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false"
        
        // Ensure the URL string is valid and can be converted to a `URL` object.
        guard let url = URL(string: webAPI) else {
            print("Error: Invalid URL")
            return
        }
        
        // Use the `NetworkingManager` to download data from the API.
        coinDetailSubscription = NetworkingManager.download(url: url)
        // Decode the JSON response into a model
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
        // Handle the completion and the received value of the subscription.
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] returnedCoinDetails in
                // Update the `coinDetails` property with the fetched data.
                self?.coinDetails = returnedCoinDetails
                // Cancel the subscription after receiving the data to free up resources.
                self?.coinDetailSubscription?.cancel()
            })
    }
}
