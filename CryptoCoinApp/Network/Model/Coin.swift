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
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case symbol
        case thumb
        case small
        case data
        case market_cap_rank
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.symbol = try container.decode(String.self, forKey: .symbol)
        self.thumb = try container.decode(String.self, forKey: .thumb)
        self.small = try container.decodeIfPresent(String.self, forKey: .small) ?? ""
        self.data = try container.decodeIfPresent(CoinData.self, forKey: .data) ?? CoinData(price: "", price_change_percentage_24h: PricePercentage(krw: 0))
        self.market_cap_rank = try container.decodeIfPresent(Int.self, forKey: .market_cap_rank) ?? 0
    }
}

struct CoinData: Decodable {
    let price: String
    let price_change_percentage_24h: PricePercentage
}

struct PricePercentage: Decodable {
    let krw: Double
}
