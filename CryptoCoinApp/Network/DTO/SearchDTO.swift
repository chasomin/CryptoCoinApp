//
//  Search.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/27/24.
//

import Foundation

struct SearchDTO: Decodable {
    let coins: [ItemDTO]
    
    func toEntity() -> Search {
        return Search(coins: coins.map{$0.toEntity()})
    }
}
