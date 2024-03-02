//
//  APIService.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/27/24.
//

import Foundation
import Alamofire

final class APIService {
    static let shared = APIService()
    private init() { }
    
    //TODO: CompletionHandler 말고 return으로 하게 되면 Repository 에서 처리하기ㅣㅣㅣㅣ~~
    func fetchTrendingAPI(api: CoinAPI, completionHandler: @escaping (Trending?, CryptoCoinError?) -> Void) {
        AF.request(api.endPoint, parameters: api.parameter).responseDecodable(of: TrendingDTO.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success.toEntity(), nil)
            case .failure(let failure):
                completionHandler(nil, .failNetworking)
            }
        }
    }
    
    func fetchCoinSearchAPI(api: CoinAPI, completionHandler: @escaping (Search?, CryptoCoinError?) -> Void) {
        AF.request(api.endPoint, parameters: api.parameter).responseDecodable(of: SearchDTO.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success.toEntity(), nil)
            case .failure(let failure):
                completionHandler(nil, .failNetworking)
            }
        }
    }
    
    func fetchCoinMarketAPI(api: CoinAPI, completionHandler: @escaping ([Market]?, CryptoCoinError?) -> Void) {
        AF.request(api.endPoint, parameters: api.parameter).responseDecodable(of: [MarketDTO].self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success.map{$0.toEntity()}, nil)
            case .failure(let failure):
                completionHandler(nil, .failNetworking)
            }
        }
    }
}
