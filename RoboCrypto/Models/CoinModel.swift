//
//  CoinModel.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-01.
//

import Foundation

// CoinGecko return JSON data Info
/*
 URL:
 https://api.coingecko.com/api/v3/coins/markets?vs_currency=cad&order=market_cap_dsc&per_page=250&page=1&sparkline=true&price_change_percentage=24h
 
 returns:
 ** Use https://app.quicktype.io/ to generate the model from the JSON response **
 
 [
    {
       "id":"bitcoin",
       "symbol":"btc",
       "name":"Bitcoin",
       "image":"https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
       "current_price":119802,
       "market_cap":2371885170410,
       "market_cap_rank":1,
       "fully_diluted_valuation":2371885170410,
       "total_volume":39912793375,
       "high_24h":121869,
       "low_24h":117871,
       "price_change_24h":-2067.697007970346,
       "price_change_percentage_24h":-1.69665,
       "market_cap_change_24h":-45723602637.52832,
       "market_cap_change_percentage_24h":-1.89127,
       "circulating_supply":19838112.0,
       "total_supply":19838112.0,
       "max_supply":21000000.0,
       "ath":157357,
       "ath_change_percentage":-24.07696,
       "ath_date":"2025-01-20T09:11:54.494Z",
       "atl":69.81,
       "atl_change_percentage":171044.43787,
       "atl_date":"2013-07-05T00:00:00.000Z",
       "roi":null,
       "last_updated":"2025-03-17T16:11:03.030Z",
       "sparkline_in_7d":{
          "price":[
             83620.17030648564,
             83263.6093863294,
             80589.75308067302
          ]
       },
       "price_change_percentage_24h_in_currency":-1.6966497388782964
    }
 ]
 
 
 */



struct CoinModel: Identifiable, Codable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H, priceChangePercentage24H, marketCapChange24H, marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings
    }
    
    
    func updateHoldings(amount: Double) -> CoinModel {
        return CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: athChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHoldings: amount)
    }
    
    var currentHoldingsValue: Double {
        return (currentHoldings ?? 0) * currentPrice
    }
    
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }
}

// MARK: - SparklineIn7D
struct SparklineIn7D: Codable {
    let price: [Double]?
}
