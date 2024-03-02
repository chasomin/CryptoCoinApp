//
//  NFT.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/28/24.
//

import Foundation

struct NFT {
    let name: String
    let symbol: String
    let thumb: String
    let data: NFTData
}

struct NFTData {
    let floorPrice: String
    let floorPriceChangePercentage: Double
}
