//
//  Coin.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/28/24.
//

import Foundation

struct Coin {
    let item: Item
}

struct Item {
    let id: String
    let name: String
    let symbol: String
    let thumb: String   // search에서 쓰이는 이미지
    let small: String  // trending에서 쓰이는 이미지
    let large: String
    let data: CoinData
    let marketRank: Int? // 순위. 정렬가능
    

}

struct CoinData {
    let price: Double
    let priceChangePercentage: PricePercentage
    
    var priceText: String {
        let digit: Double = pow(10, 3)
        return "$\(round(price * digit) / digit)"
    }
}

struct PricePercentage {
    let krw: Double
}
