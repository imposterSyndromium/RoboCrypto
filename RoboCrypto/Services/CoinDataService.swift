//
//  CoinDataService.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-18.
//
//



import Foundation
import Combine

/// A service class that fetches cryptocurrency data from the CoinGecko API.
///
/// Explanation of Key Components:
    ///@Published Property:
    ///
    ///The @Published property wrapper is used to notify subscribers (e.g., SwiftUI views) whenever the allCoins array is updated.
    ///coinSubscription:
    ///
    ///This is an AnyCancellable object that represents the Combine subscription. It ensures that the subscription is properly managed and can be canceled when no longer needed.
    ///init():
    ///
    ///The initializer calls the getCoins() function to start fetching cryptocurrency data as soon as the CoinDataService object is created.
    ///getCoins():
    ///
    ///This function performs the following steps:
    ///Constructs the API URL.
    ///Uses the NetworkingManager.download method to fetch data from the API.
    ///Decodes the JSON response into an array of CoinModel objects.
    ///Updates the allCoins property with the fetched data.
    ///Cancels the subscription after the data is received to avoid unnecessary resource usage.
    ///Combine Framework:
    ///
    ///The sink operator is used to handle both the completion event (success or failure) and the received data (an array of CoinModel).
    ///Weak Self:
    ///
    ///The [weak self] capture list is used in the closure to prevent a strong reference cycle, which could lead to memory leaks.
    ///class CoinDataService {
///
class CoinDataService {
    
    /// A published property that holds an array of all fetched coins.
    /// - Note: This property is marked with `@Published` to allow SwiftUI views or other subscribers to react to changes in its value.
    @Published var allCoins: [CoinModel] = []
    
    /// A cancellable object that represents the subscription to the Combine publisher.
    /// - Note: This is used to manage the lifecycle of the subscription to avoid memory leaks.
    var coinSubscription: AnyCancellable?
    
    /// Initializes the `CoinDataService` and triggers the fetching of coin data.
    init() {
        getCoins()
    }
    
    /// Fetches all coins from the CoinGecko API.
    /// - Note: The API is paginated, and this function fetches the first page of 250 coins.
    /// - The data is fetched in CAD currency, ordered by market capitalization in descending order.
    /// - The API also includes sparkline data and 24-hour price change percentages.
    private func getCoins() {
        // The URL for the CoinGecko API endpoint to fetch cryptocurrency data.
        let webAPI = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=cad&order=market_cap_dsc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
        
        // Ensure the URL string is valid and can be converted to a `URL` object.
        guard let url = URL(string: webAPI) else {
            print("Error: Invalid URL")
            return
        }
        
        // Use the `NetworkingManager` to download data from the API.
        coinSubscription = NetworkingManager.download(url: url)
            // Decode the JSON response into an array of `CoinModel` objects.
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            // Handle the completion and the received value of the subscription.
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] returnedCoins in
                      // Update the `allCoins` property with the fetched data.
                      self?.allCoins = returnedCoins
                      // Cancel the subscription after receiving the data to free up resources.
                      self?.coinSubscription?.cancel()
                  })
    }
}



        //Explanation of Key Components:
        //@Published Property:
        //
        //The @Published property wrapper is used to notify subscribers (e.g., SwiftUI views) whenever the allCoins array is updated.
        //coinSubscription:
        //
        //This is an AnyCancellable object that represents the Combine subscription. It ensures that the subscription is properly managed and can be canceled when no longer needed.
        //init():
        //
        //The initializer calls the getCoins() function to start fetching cryptocurrency data as soon as the CoinDataService object is created.
        //getCoins():
        //
        //This function performs the following steps:
        //Constructs the API URL.
        //Uses the NetworkingManager.download method to fetch data from the API.
        //Decodes the JSON response into an array of CoinModel objects.
        //Updates the allCoins property with the fetched data.
        //Cancels the subscription after the data is received to avoid unnecessary resource usage.
        //Combine Framework:
        //
        //The sink operator is used to handle both the completion event (success or failure) and the received data (an array of CoinModel).
        //Weak Self:
        //
        //The [weak self] capture list is used in the closure to prevent a strong reference cycle, which could lead to memory leaks.



//import Foundation
//import Combine
//
//
//class CoinDataService {
//    
//    @Published var allCoins: [CoinModel] = []
//    var coinSubscription: AnyCancellable?    
//    
//    init() {
//        getCoins()
//    }
//    
//    ///  Fetches all coins from the CoinGecko API
//    ///  - Note: The API is paginated, so we're only fetching the first page of 250 coins
//    private func getCoins() {
//        let webAPI = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=cad&order=market_cap_dsc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
//        
//        guard let url = URL(string: webAPI) else {
//            print("Error: Invalid URL")
//            return
//        }
//        
//        coinSubscription = NetworkingManager.download(url: url)
//            // decode the JSON data into CoinModel
//            .decode(type: [CoinModel].self, decoder: JSONDecoder())
//            // sink is used to handle the completion and the value of the subscription
//            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCoins in
//                self?.allCoins = returnedCoins
//                self?.coinSubscription?.cancel()
//            })
//        
//           
//            
//    }
//}




