//
//  ConversionRateService.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-18.
//

import Foundation
import Combine

/// A service class that fetches the USD to CAD conversion rate from an API.
class ConversionRateService {
    
    /// A published property that holds the fetched USD to CAD conversion rate.
    @Published var conversionRate: Double? = nil
    
    /// A cancellable object that represents the subscription to the Combine publisher.
    var rateSubscription: AnyCancellable?
    
    /// Initializes the `ConversionRateService` and triggers the fetching of the conversion rate.
    init() {
        getConversionRate()
    }
    
    /// Fetches the USD to CAD conversion rate from the API.
    func getConversionRate() {
        // The URL for the API endpoint to fetch the conversion rate.
        let urlString = "https://api.exchangerate-api.com/v4/latest/USD"
        
        // Ensure the URL string is valid and can be converted to a `URL` object.
        guard let url = URL(string: urlString) else {
            print("Error: Invalid URL")
            return
        }
        
        // Use the `NetworkingManager` to download data from the API.
        rateSubscription = NetworkingManager.download(url: url)
            // Decode the JSON response into a dictionary.
            .tryMap { data -> Double? in
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                let rates = json?["rates"] as? [String: Double]
                return rates?["CAD"]
            }
            // Replace errors with nil.
            .replaceError(with: nil)
            // Move to the main thread.
            .receive(on: DispatchQueue.main)
            // Handle the completion and the received value of the subscription.
            .sink(receiveValue: { [weak self] rate in
                print("Received conversion rate: \(String(describing: rate))")
                self?.conversionRate = rate
                self?.rateSubscription?.cancel()
            })
    }
}
