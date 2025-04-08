//
//  CoinLogoCardView.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-26.
//

import SwiftUI

struct CoinLogoCardView: View {
    let coin: CoinModel
    
    var body: some View {
        VStack {
            CoinLogoView(coin: coin)
                .frame(width: 50, height: 50)
            
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            Text(coin.name)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CoinLogoCardView(coin: CoinModel.sample)
}
