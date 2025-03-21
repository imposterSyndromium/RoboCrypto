//
//  CoinRowView.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-17.   
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
    let showHoldingsColumn: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            
            Spacer()
            
            if showHoldingsColumn {
                centerColumn
            }
            
            rightColumn
        }
        .font(.subheadline)
    }
}




#Preview(traits: .sizeThatFitsLayout) {
    let coin = CoinModel.sample
    Group {
        CoinRowView(coin: coin, showHoldingsColumn: true)
           
        
        CoinRowView(coin: coin, showHoldingsColumn: false)
     
            
          
    }
}



//struct CoinRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            CoinRowView(coin: dev.coin, showHoldingsColumn: true)
//                .previewLayout(.sizeThatFits)
//            
//            CoinRowView(coin: dev.coin, showHoldingsColumn: true)
//                .previewLayout(.sizeThatFits)
//                .preferredColorScheme(.dark)
//        }
//    }
//}



extension CoinRowView {
    
    private var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 30)
            
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
                
            VStack(alignment: .leading) {
                
                Text(coin.symbol.uppercased())
                    .font(.headline)
                    .foregroundColor(Color.theme.accent)
                
                Text(coin.name)
                    .foregroundColor(Color.theme.secondaryText)
                
            }
            .padding(.leading, 5)
        }
    }
    
    
    private var centerColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                
            Text((coin.currentHoldings ?? 0).asNumberString())
                .foregroundStyle((coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.greenColor : Color.theme.redColor)
        }
    }
    
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .foregroundColor(Color.theme.accent)
                .font(.headline)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "0%")
                .foregroundStyle(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ?
                    Color.theme.greenColor : Color.theme.redColor)
                
                
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
    
    
}

