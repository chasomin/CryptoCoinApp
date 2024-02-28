//
//  NFT.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/27/24.
//

import Foundation

struct NFTDTO: Decodable {
    let name: String
    let symbol: String
    let thumb: String
    let data: NFTDataDTO
    
    func toEntity() -> NFT{
        return NFT(name: name,
                   symbol: symbol,
                   thumb: thumb,
                   data: data.toEntity())
    }
}

struct NFTDataDTO: Decodable {
    let floor_price: String
    let floor_price_in_usd_24h_percentage_change: String
    
    func toEntity() -> NFTData{
        return NFTData(floorPrice: floor_price,
                       floorPriceChangePercentage: floor_price_in_usd_24h_percentage_change)
    }
}
