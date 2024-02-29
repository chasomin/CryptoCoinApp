//
//  TrendingViewModel.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 3/1/24.
//

import Foundation

final class TrendingViewModel {
    let inputFetchDataTrigger: Observable<Void?> = Observable(nil)
    let inputWhatKindOfCell: Observable<Int?> = Observable(nil)
    let outputData: Observable<Trending?> = Observable(nil)
    
    init() {
        inputFetchDataTrigger.bind { value in
            guard let value else { return }
            APIService.shared.fetchTrendingAPI(api: .trending) { data, error in
                if error != nil {
                    // TODO: 에러
                } else {
                    self.outputData.value = data
                }
            }
        }
    }
}
