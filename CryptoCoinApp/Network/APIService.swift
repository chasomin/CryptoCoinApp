//
//  APIService.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/27/24.
//

import Foundation
import Alamofire

//TODO: ErrorHandling
enum CoinError: Error {
    
}

final class APIService {
    static let shared = APIService()
    private init() { }
    
    func fetchTrendingAPI(api: CoinAPI, completionHandler: @escaping (Trending?, Error?) -> Void) {
        AF.request(api.endPoint, parameters: api.parameter).responseDecodable(of: Trending.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success, nil)
            case .failure(let failure):
                completionHandler(nil, failure)
            }
        }
    }
    
    func fetchCoinSearchAPI(api: CoinAPI, completionHandler: @escaping (Search?, Error?) -> Void) {
        AF.request(api.endPoint, parameters: api.parameter).responseDecodable(of: Search.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success, nil)
            case .failure(let failure):
                completionHandler(nil, failure)
            }
        }
    }
    
    func fetchCoinMarketAPI(api: CoinAPI, completionHandler: @escaping ([Market]?, Error?) -> Void) {
        AF.request(api.endPoint, parameters: api.parameter).responseDecodable(of: [Market].self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success, nil)
            case .failure(let failure):
                completionHandler(nil, failure)
            }
        }
    }
}
