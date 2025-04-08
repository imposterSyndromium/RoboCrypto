//
//  CoinLogoView.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-26.
//

import SwiftUI

struct CoinLogoView: View {
    
    let coin: CoinModel
    
    var body: some View {
        VStack {
            CoinImageView(coin: coin)
        }
    }
}

#Preview {
    CoinLogoView(coin: CoinModel.sample)
}
