//
//  Trending.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/27/24.
//

import Foundation

struct TrendingDTO: Decodable {
    let coins: [CoinDTO]
    let nfts: [NFTDTO]
    
    
    func toEntity() -> Trending {
        return Trending(coins: coins.map{$0.toEntity()},
                        nfts: nfts.map{$0.toEntity()})
    }

}
