//
//  CoinImageService.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-19.
//

import Combine
import Foundation
import SwiftUI


class CoinImageService {
    
    @Published var image: UIImage? = nil
    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage() {
                
        guard let url = URL(string: coin.image) else {
            print("Error: Invalid URL")
            return
        }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            // sink is used to handle the completion and the value of the subscription
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
                self?.imageSubscription?.cancel()
            })
    }
}
