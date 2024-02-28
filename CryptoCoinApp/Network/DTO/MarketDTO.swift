//
//  Market.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/27/24.
//

import Foundation

struct MarketDTO: Decodable {
    let id: String
    let name: String
    let symbol: String
    let image: String
    let current_price: Double
    let price_change_percentage_24h: Double
    let low_24h: Double
    let high_24h: Double
    let ath: Double
    let ath_date: String
    let atl: Double
    let atl_date: String
    let last_updated: String
    let sparkline_in_7d: SparklineDTO
    
    func toEntity() -> Market {
        return Market(id: id,
                      name: name,
                      symbol: symbol,
                      image: image,
                      currentPrice: Int(current_price),
                      priceChangePercentage: price_change_percentage_24h,
                      low: Int(low_24h),
                      high: Int(high_24h),
                      allTimeHigh: Int(ath),
                      athDate: ath_date,
                      allTimeLow: Int(atl),
                      atlDate: atl_date,
                      lastUpdated: last_updated,
                      sparkline: Sparkline(price: sparkline_in_7d.price))
    }
}

struct SparklineDTO: Decodable {
    let price: [Double]
}
