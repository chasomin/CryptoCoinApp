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
    let priceChangePercentage: Double
    let low: Int
    let high: Int
    let allTimeHigh: Int
    let athDate: String
    let allTimeLow: Int
    let atlDate: String
    let lastUpdated: String
    let sparkline: Sparkline
}
struct Sparkline: Decodable {
    let price: [Double]
}
