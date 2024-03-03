//
//  SearchViewModel.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/27/24.
//

import Foundation

final class SearchViewModel {
    let repository = RealmFavoriteCoinRepository()
    
    var inputSearchButtonTapped: Observable<String?> = Observable(nil)
    var inputFavoriteButtonTapped: Observable<Int?> = Observable(nil)
    var inputViewWillAppearTrigger: Observable<Void?> = Observable(nil)
    var outputCoinList: Observable<[Item]> = Observable([])
    var outputError: Observable<String?> = Observable(nil)
    var outputFavoriteButtonTapped: Observable<String?> = Observable(nil)
    
    var oldValue = ""
    
    init() {
        inputSearchButtonTapped.bind { value in
            guard let value else { return }
            self.vaildSearchText(value)
        }
        
        inputFavoriteButtonTapped.bind { tag in
            guard let tag else { return }
            let id = self.outputCoinList.value[tag].id
            
            self.outputFavoriteButtonTapped.value = self.saveOrDeleteItem(id)
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
            if error != nil {
                self.outputError.value = error!.rawValue
            } else {
                guard let data else { return }
                self.outputCoinList.value = data.coins
            }
        }
        oldValue = value
    }
    
    func saveOrDeleteItem(_ id: String) -> String{
        if repository.fetchItem().filter({$0.id == id}).isEmpty {
            if repository.fetchItem().count < 10 {
                repository.createItem(id)
                return "즐겨찾기에 저장됐어요"
            } else {
                return "10개까지만 저장할 수 있어요"
            }
        } else {
            repository.deleteItem(id)
            return "즐겨찾기에서 삭제됐어요"
        }
    }
}
