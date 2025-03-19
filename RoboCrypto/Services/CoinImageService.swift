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
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
            print("\(Date()): Retrieved image from file manager")
        } else {
            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage() {
        print("\(Date()): Downloading coin image...")
                
        guard let url = URL(string: coin.image) else {
            print("Error: Invalid URL")
            return
        }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            // sink is used to handle the completion and the value of the subscription
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
}
