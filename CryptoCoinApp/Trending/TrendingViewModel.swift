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
    let outputError: Observable<String?> = Observable(nil)
    
    init() {
        inputFetchDataTrigger.bind { value in
            guard value != nil else { return }
            APIService.shared.fetchTrendingAPI(api: .trending) { data, error in
                if error != nil {
                    self.outputError.value = error!.rawValue
                } else {
                    self.outputData.value = data
                }
            }
        }
    }
}
