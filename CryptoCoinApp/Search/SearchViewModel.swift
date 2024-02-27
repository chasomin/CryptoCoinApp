//
//  SearchViewModel.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/27/24.
//

import Foundation

final class SearchViewModel {
    var inputSearchButtonClicked = Observable("")
    var outputCoinList: Observable<[Item]> = Observable([])
    
    init() {
        inputSearchButtonClicked.bind { value in
            APIService.shared.fetchCoinSearchAPI(api: .search(text: value)) { data, error in
                if let error {
                    //TODO: toast
                } else {
                    guard let data else { return }
                    self.outputCoinList.value = data.coins
                }
            }
        }
    }
}
