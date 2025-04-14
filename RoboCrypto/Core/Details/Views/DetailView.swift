//
//  DetailView.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-04-11.
//

import SwiftUI


struct DetailView: View {
    
    @StateObject private var vm: DetailViewModel
    let coin: CoinModel
    
    // just to show how the view is initialized when using navigationLink vs navigationDestination
    init(coin: CoinModel) {
        self.coin = coin
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("Initializing detail view for \(coin.name)")
    }
    
    
    var body: some View {
        Text("\(coin.name) detail view")
    }
}



#Preview {
    DetailView(coin: CoinModel.sample)
}


