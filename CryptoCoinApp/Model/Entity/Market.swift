//
//  Market.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/28/24.
//

import Foundation

struct Market {
    let id: String
    let name: String
    let symbol: String
    let image: String
    let currentPrice: Int
    var priceString: String {
        currentPrice.priceKRWCalculator()
    }
    let priceChangePercentage: Double
    var changePercentageString: String {
        priceChangePercentage.decimalCalculator()
    }
    let low: Int
    var lowString: String {
        low.priceKRWCalculator()
    }
    let high: Int
    var highString: String {
        high.priceKRWCalculator()
    }
    let allTimeHigh: Int
    var allTimeHighString: String {
        allTimeHigh.priceKRWCalculator()
    }
    let athDate: String
    let allTimeLow: Int
    var allTimeLowString: String {
        allTimeLow.priceKRWCalculator()
    }
    let atlDate: String
    let lastUpdated: String
    var update: String {
        lastUpdated.stringDate()
    }
    let sparkline: Sparkline
}
struct Sparkline: Decodable {
    let price: [Double]
}
