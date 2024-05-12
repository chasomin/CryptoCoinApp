//
//  Coin.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/27/24.
//

import Foundation

struct CoinDTO: Decodable {
    let item: ItemDTO
    
    func toEntity() -> Coin {
        return Coin(item: item.toEntity())
    }

}

struct ItemDTO: Decodable {
    let id: String
    let name: String
    let symbol: String
    let thumb: String
    let small: String?   // trending에서 쓰이는 이미지
    let large: String?   // search에서 쓰이는 이미지
    let data: CoinDataDTO?
    let market_cap_rank: Int? // 순위. 정렬가능
    
    func toEntity() -> Item {
        return Item(id: id,
                    name: name,
                    symbol: symbol,
                    thumb: thumb,
                    small: small ?? "",
                    large: large ?? "",
                    data: data?.toEntity() ?? CoinData(price: 0, priceChangePercentage: PricePercentage(krw: 0)),
                    marketRank: market_cap_rank)
    }
    

}

struct CoinDataDTO: Decodable {
    let price: Double
    let price_change_percentage_24h: PricePercentageDTO
    
    func toEntity() -> CoinData {
        return CoinData(price: price,
                        priceChangePercentage: price_change_percentage_24h.toEntity())
    }
}

struct PricePercentageDTO: Decodable {
    let krw: Double
    
    func toEntity() -> PricePercentage {
        return PricePercentage(krw: krw)
    }
}
