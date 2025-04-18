//
//  StatisticalModel.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-03-21.
//

import Foundation


struct StatisticModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}


extension StatisticModel {
    // sample data
    static let stat1 = StatisticModel(title: "24hr Change", value: "$1.23bn", percentageChange: 12.34)
    static let stat2 = StatisticModel(title: "Market Cap", value: "$2.3Tn")
    static let stat3 = StatisticModel(title: "Portfolio", value: "$1.3Mi", percentageChange: -1.23)
}


