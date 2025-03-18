//
//  NetworkingManager.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-18.
//

import Foundation
import Combine

class NetworkingManager {
    
    ///   This function is used to download data from a URL
    /// - Parameter url:  The URL of the data to be downloaded
    /// - Returns:  A publisher that emits the data from the URL
    /// - Note:  This function is used to download data from a URL. It uses the URLSession.shared.dataTaskPublisher(for:) method to create a publisher that emits the data from the URL. The publisher is then transformed using the tryMap operator to check the response from the server and throw an error if the response is not successful. The receive(on:) operator is used to receive the data on the main thread, which is important if you're using the data to update the UI. Finally, the eraseToAnyPublisher() operator is used to erase the specific type of the publisher and return an AnyPublisher that can be used in the rest of your code
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        
       return URLSession.shared.dataTaskPublisher(for: url)
            // subscribe on a background thread (which is probably already done by default)
            .subscribe(on: DispatchQueue.global(qos: .default))
            // tryMap is used to check the response from the server
            .tryMap { (output) -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    print("Error (.tryMap server response error): \(output.response)")
                    throw URLError(.badServerResponse)
                }
                print ("Successful API call/response: \(output.response)")
                
                //                // Print the raw data as a string
                //                if let jsonString = String(data: output.data, encoding: .utf8) {
                //                    print("JSON Data: \(jsonString)")
                //                }
                //
                //                // Alternatively, for prettier formatting:
                //                if let jsonObject = try? JSONSerialization.jsonObject(with: output.data),
                //                   let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
                //                   let prettyString = String(data: prettyData, encoding: .utf8) {
                //                    print("Pretty JSON:\n\(prettyString)")
                //                }
                
                return output.data
            }
            // receive on the main thread because we're using it to update UI
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
            case .finished:
                break
            case .failure(let error):
                print("Error (.sink error): \(error.localizedDescription)")
        }
    }
}
