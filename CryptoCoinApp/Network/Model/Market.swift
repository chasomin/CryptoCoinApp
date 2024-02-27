//
//  Market.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/27/24.
//

import Foundation

struct Market: Decodable {
    let id: String
    let name: String
    let symbol: String
    let image: String
    let current_price: Int
    let price_change_percentage_24h: Double
    let low_24h: Int
    let high_24h: Int
    let ath: Int
    let ath_date: String
    let atl: Int
    let atl_date: String
    let last_updated: String
    let sparkline_in_7d: Sparkline
}

struct Sparkline: Decodable {
    let price: [Double]
}
