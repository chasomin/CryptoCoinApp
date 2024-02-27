//
//  CoinAPI.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/27/24.
//

import Foundation
import Alamofire

enum CoinAPI {
    case trending
    case search(text: String)
    case market(id: String)
    
    var baseURL: String {
        "https://api.coingecko.com/api/v3/"
    }
    
    var endPoint: String {
        switch self {
        case .trending:
            baseURL + "search/trending"
        case .search:
            baseURL + "search"
        case .market:
            baseURL + "coins/markets"
        }
    }
    
    var parameter: Parameters {
        switch self {
        case .trending:
            ["":""]
        case .search(let text):
            ["query":text]
        case .market(let id):
            ["vs_currency":"krw",
             "ids":id,              //id 여러개 ,로 붙여서 검색도 가능
             "sparkline":"true"]
        }
    }
}
