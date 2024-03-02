//
//  FavoriteViewModel.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/29/24.
//

import Foundation

final class FavoriteViewModel {
    let repository = RealmFavoriteCoinRepository()
    
    let inputViewWillAppearTrigger: Observable<Void?> = Observable(nil)
    let inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    
    let outputData: Observable<[Market]> = Observable([])
    var outputError: Observable<String?> = Observable(nil)
    init() {
        inputViewWillAppearTrigger.bind { value in
            guard value != nil else { return }
            var id = [""]
            if self.repository.fetchItem().map({$0.id}).isEmpty {
                id = ["."]
            } else {
                id = self.repository.fetchItem().map{$0.id}
            }
            APIService.shared.fetchCoinMarketAPI(api: .market(id: id)) { data, error in
                if error != nil {
                    self.outputError.value = error!.rawValue
                } else {
                    guard let data else { return }
                    self.outputData.value = data
                }
            }
        }
    }
}
