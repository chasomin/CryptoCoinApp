//
//  Coin.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/27/24.
//

import Foundation

struct Coin: Decodable {
    let item: Item
}

struct Item: Decodable {
    let id: String
    let name: String
    let symbol: String
    let thumb: String   // search에서 쓰이는 이미지
    let small: String?   // trending에서 쓰이는 이미지
    let data: CoinData?
    let market_cap_rank: Int? // 순위. 정렬가능
}

struct CoinData: Decodable {
    let price: String
    let price_change_percentage_24h: PricePercentage
}

struct PricePercentage: Decodable {
    let krw: Double
}
