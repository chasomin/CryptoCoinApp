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
                    self.outputError.value = "잠시후에 다시 시도해주세요"
                } else {
                    guard let data else { return }
                    print("마켓 데이터 받음 -> OUPPUTData 변화")
                    self.outputData.value = data
                }
            }
        }
    }
}
