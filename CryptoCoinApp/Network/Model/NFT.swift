//
//  NFT.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/27/24.
//

import Foundation

struct NFT: Decodable {
    let name: String
    let symbol: String
    let thumb: String
    let data: NFTData
}

struct NFTData: Decodable {
    let floor_price: String
    let floor_price_in_usd_24h_percentage_change: String
}
