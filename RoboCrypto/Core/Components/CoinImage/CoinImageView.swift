//
//  CoinImageView.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-19.
//

import SwiftUI



///  A view that displays a coin image
///  - Parameter coin: The coin model to display the image for
///  - Returns: A view that displays a coin image
struct CoinImageView: View {
    
    @StateObject var vm: CoinImageViewModel
    
    ///  Initializes a new instance of the view with the specified coin model
    /// - Parameter coin:  The coin model to display the image for
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundStyle(Color.theme.secondaryText)
            }
        }
    }
}


#Preview {
    CoinImageView(coin: CoinModel.sample)
}
