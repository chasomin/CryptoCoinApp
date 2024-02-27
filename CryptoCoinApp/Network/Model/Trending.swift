//
//  Trending.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/27/24.
//

import Foundation

struct Trending: Decodable {
    let coins: [Coin]
    let nfts: [NFT]
}
