//
//  SearchViewModel.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/27/24.
//

import Foundation

final class SearchViewModel {
    var inputSearchButtonClicked: Observable<String?> = Observable(nil)
    
    var outputCoinList: Observable<[Item]> = Observable([])
    var outputError: Observable<String?> = Observable(nil)
    
    var oldValue = ""
    
    init() {
        inputSearchButtonClicked.bind { value in
            guard let value else { return }
            self.vaildSearchText(value)
        }
    }
    
    func vaildSearchText(_ value: String) {
        let value = value.lowercased().trimmingCharacters(in: .whitespaces)

        if value.isEmpty {
            outputError.value = "검색어를 입력해주세요"
            return
        }
        
        // 방금 전 검색어와 같은 검색어면 네트워트 요청 X
        if oldValue == value {
            return
        }

        APIService.shared.fetchCoinSearchAPI(api: .search(text: value)) { data, error in
            print("네트워크 요청")
            if error != nil {
                self.outputError.value = "잠시후에 다시 시도해주세요"
            } else {
                guard let data else { return }
                self.outputCoinList.value = data.coins
            }
        }
        oldValue = value
        print(value)
    }
    
}
