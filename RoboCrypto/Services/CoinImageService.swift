//
//  CoinImageService.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-19.
//


import Combine
import Foundation
import SwiftUI

/// A service class responsible for managing the retrieval and caching of coin images.
///
/// This class uses Combine to handle asynchronous image downloading and caching.
/// It stores images locally using a `LocalFileManager` instance.
/// It also provides a published property to allow SwiftUI views to reactively update when the image changes.
/// The class is initialized with a `CoinModel` object, which contains details about the coin, including its image URL.
/// The image is downloaded from the network if it is not found in local storage.
/// The downloaded image is saved locally for future use.
/// The class also handles the conversion of downloaded data into a `UIImage`.
/// It uses a Combine pipeline to manage the downloading process and handle errors.
/// The class is designed to be lightweight and efficient, ensuring that images are only downloaded when necessary.
/// It also provides a mechanism to cancel ongoing downloads when they are no longer needed.
///
/// Usage:
/// ```swift
/// let coinImageService = CoinImageService(coin: coinModel)
/// coinImageService.$image
///    .sink { image in
///    // Update UI with the downloaded image
///    }
///    ```
///
///    - Note: This class is part of a larger application that deals with cryptocurrency data.
///
///    Summary of Key Components:
///     @Published var image: A reactive property that holds the coin image and updates any SwiftUI views observing it.
///     imageSubscription: Manages the Combine pipeline for downloading the image.
///     coin: The coin model containing details like the image URL.
///     fileManager: A utility for saving and retrieving images locally.
///     folderName and imageName: Define the storage location and file name for the coin image.
///     getCoinImage(): Checks if the image exists locally; if not, triggers a download.
///     downloadCoinImage(): Handles downloading the image from the network and saving it locally.
///     class CoinImageService {
class CoinImageService {
    
    // MARK: - Published Properties
    
    /// A published property that holds the image of the coin.
    /// This allows SwiftUI views to reactively update when the image changes.
    @Published var image: UIImage? = nil
    
    // MARK: - Private Properties
    
    /// A subscription object for managing the Combine pipeline for downloading the image.
    private var imageSubscription: AnyCancellable?
    
    /// The coin model associated with this service, containing details about the coin.
    private let coin: CoinModel
    
    /// A singleton instance of the local file manager used for saving and retrieving images from local storage.
    private let fileManager = LocalFileManager.instance
    
    /// The name of the folder where coin images are stored locally.
    private let folderName = "coin_images"
    
    /// The name of the image file, derived from the coin's unique identifier.
    private let imageName: String
    
    // MARK: - Initializer
    
    /// Initializes the `CoinImageService` with a specific coin model.
    /// - Parameter coin: The `CoinModel` object representing the coin whose image is being managed.
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage() // Attempts to retrieve the coin image from local storage or downloads it if not available.
    }
    
    // MARK: - Private Methods
    
    /// Attempts to retrieve the coin image from local storage.
    /// If the image is found, it is assigned to the `image` property.
    /// If not, it triggers the download of the image from the network.
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage // Assigns the retrieved image to the published property.
            print("\(Date()): Retrieved image from file manager") // Logs the retrieval.
        } else {
            downloadCoinImage() // Initiates the download if the image is not found locally.
        }
    }
    
    /// Downloads the coin image from the network.
    /// The downloaded image is saved locally and assigned to the `image` property.
    private func downloadCoinImage() {
        print("\(Date()): Downloading coin image...") // Logs the start of the download process.
        
        // Validates and constructs the URL for the coin image.
        guard let url = URL(string: coin.image) else {
            print("Error: Invalid URL") // Logs an error if the URL is invalid.
            return
        }
        
        // Creates a Combine pipeline to download the image data from the URL.
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                // Attempts to convert the downloaded data into a UIImage.
                return UIImage(data: data)
            })
            // Handles the completion and the value of the subscription.
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                // Ensures self is not retained strongly and processes the returned image.
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = downloadedImage // Updates the published property with the downloaded image.
                self.imageSubscription?.cancel() // Cancels the subscription to free resources.
                // Saves the downloaded image to local storage for future use.
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
}



        //Summary of Key Components:
        //@Published var image: A reactive property that holds the coin image and updates any SwiftUI views observing it.
        //imageSubscription: Manages the Combine pipeline for downloading the image.
        //coin: The coin model containing details like the image URL.
        //fileManager: A utility for saving and retrieving images locally.
        //folderName and imageName: Define the storage location and file name for the coin image.
        //getCoinImage(): Checks if the image exists locally; if not, triggers a download.
        //downloadCoinImage(): Handles downloading the image from the network and saving it locally.





//import Combine
//import Foundation
//import SwiftUI
//
//
//class CoinImageService {
//    
//    @Published var image: UIImage? = nil
//    private var imageSubscription: AnyCancellable?
//    private let coin: CoinModel
//    private let fileManager = LocalFileManager.instance
//    private let folderName = "coin_images"
//    private let imageName: String
//    
//    init(coin: CoinModel) {
//        self.coin = coin
//        self.imageName = coin.id
//        getCoinImage()
//    }
//    
//    private func getCoinImage() {
//        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
//            image = savedImage
//            print("\(Date()): Retrieved image from file manager")
//        } else {
//            downloadCoinImage()
//        }
//    }
//    
//    private func downloadCoinImage() {
//        print("\(Date()): Downloading coin image...")
//                
//        guard let url = URL(string: coin.image) else {
//            print("Error: Invalid URL")
//            return
//        }
//        
//        imageSubscription = NetworkingManager.download(url: url)
//            .tryMap({ (data) -> UIImage? in
//                return UIImage(data: data)
//            })
//            // sink is used to handle the completion and the value of the subscription
//            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
//                guard let self = self, let downloadedImage = returnedImage else { return }
//                self.image = downloadedImage
//                self.imageSubscription?.cancel()
//                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
//            })
//    }
//}
