//
//  NetworkingManager.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-18.
//


import Foundation
import Combine



class NetworkingManager {
    
    static let printJSONResultStringInDebugWindow: Bool = false
    
    
    ///  This enum is used to represent errors that can occur during networking
    ///  - badURLResponse:  An error that occurs when the URL response is invalid with the URL that caused the error
    ///  - unknown:  An unknown error that occurs during networking with a description of the error
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown(error: String)
        
        var errorDescription: String? {
            switch self {
                case .badURLResponse(url: let url): return "[🔥] Bad URL Response from: \n \(url)"
                case .unknown(error: let errorDescription): return "[⚠️] Unknown Error in [\(errorDescription)]"
            }
        }
    }
    
    
    
    ///   This function is used to download data from a URL
    /// - Parameter url:  The URL of the data to be downloaded
    /// - Returns:  A publisher that emits the data from the URL
    /// - Note:  This function is used to download data from a URL. It uses the URLSession.shared.dataTaskPublisher(for:) method to create a publisher that emits the data from the URL. The publisher is then transformed using the tryMap operator to check the response from the server and throw an error if the response is not successful. The receive(on:) operator is used to receive the data on the main thread, which is important if you're using the data to update the UI. Finally, the eraseToAnyPublisher() operator is used to erase the specific type of the publisher and return an AnyPublisher that can be used in the rest of your code
    static func download(url: URL) -> AnyPublisher<Data, Error> {
       return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ try handleURLResponse(output: $0) })
            .retry(3)
            //.receive(on: DispatchQueue.main)  //<-- moved the transfer to main thread from this method to each subscriber (after decoding)
            .eraseToAnyPublisher()
    }
    
    
    
    ///  This function is used to handle the response from a URL request
    /// - Parameter output:  The output from a URLSession.DataTaskPublisher
    /// - Returns:  The data from the URL response if the response is successful
    /// - Throws:  An error if the response is not successful
    /// - Note:  This function is used to handle the response from a URL request. It checks the response from the server and throws an error if the response is not successful. This is important because you want to handle errors as soon as possible in your code. If the response is successful, the function returns the data from the URL
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            print("Error (URL response error): \(output.response)")
            throw URLError(.badServerResponse)
        }
        
        /// Print the raw data as a string
        //                if let jsonString = String(data: output.data, encoding: .utf8) {
        //                    print("JSON Data: \(jsonString)")
        //                }
        //
        /// Alternatively, for prettier formatting:
        if printJSONResultStringInDebugWindow {
            if let jsonObject = try? JSONSerialization.jsonObject(with: output.data),
               let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
               let prettyString = String(data: prettyData, encoding: .utf8) {
                print("Pretty JSON:\n\(prettyString)")
            }
        }

        
        return output.data
    }
    
    
    
    ///  This function is used to handle the completion of a publisher subscription
    /// - Parameter completion:  The completion of a publisher subscription (either finished or failed)
    /// - Throws:  An error if the completion is a failure
    /// - Note:  This function is used to handle the completion of a publisher subscription. It checks the completion of the subscription and throws an error if the completion is a failure. This is important because you want to handle errors as soon as possible in your code
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
            case .finished:
                break
            case .failure(let error):
                print("Error in handleCompletion(): \(error.localizedDescription)")
                //throw NetworkingError.unknown(error: "handleCompletion()")
        }
    }
}






