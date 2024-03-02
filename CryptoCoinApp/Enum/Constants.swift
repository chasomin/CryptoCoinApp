//
//  Constants.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/27/24.
//

import Foundation

enum Constants {
    enum NavigationTitle: String {
        case trending = "Crypto Coin"
        case search = "Search"
        case favorite = "Favorite Coin"
        case user = "User"
    }
    
    enum TrendingCellTitle: Int, CaseIterable {
        case favorite
        case topCoin
        case topNFT
        
        var title: String {
            switch self {
            case .favorite:
                "My Favorite"
            case .topCoin:
                "Top 15 Coin"
            case .topNFT:
                "Top 7 NFT"
            }
        }
    }
}
