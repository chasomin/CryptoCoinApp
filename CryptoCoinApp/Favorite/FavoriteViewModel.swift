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
    let inputRefreshControl: Observable<Void?> = Observable(nil)
//    let inputCellDragAndDrop:Observable<(String, Int)?> = Observable(nil)
    
    let outputData: Observable<[Market]> = Observable([])
    let outputError: Observable<String?> = Observable(nil)
    let outputRefresh: Observable<Void?> = Observable(nil)
//    let outputCellDragAndDrop: Observable<Void?> = Observable(nil)
    
    init() {
        inputViewWillAppearTrigger.bind { value in
            guard value != nil else { return }
            var id = [""]
            if self.repository.fetchItem().map({$0.id}).isEmpty {
                id = ["."]
            } else {
                id = self.repository.fetchItem().map{$0.id}
            }
            self.fetch(id: id)
            Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { _ in
                self.fetch(id: id)
            }
        }
        inputRefreshControl.bind { value in
            guard let value else { return }
            var id = [""]
            if self.repository.fetchItem().map({$0.id}).isEmpty {
                id = ["."]
            } else {
                id = self.repository.fetchItem().map{$0.id}
            }
            APIService.shared.fetchCoinMarketAPI(api: .market(id: id)) { data, error in
                if error != nil {
                    self.outputError.value = error!.rawValue
                    self.outputRefresh.value = ()
                } else {
                    guard let data else { return }
                    self.outputData.value = data
                    self.outputRefresh.value = ()
                }
            }
        }
//        inputCellDragAndDrop.bind { value in
//            guard let value else { return }
//            self.repository.changeItem(value.0, index: value.1)
//            self.outputCellDragAndDrop.value = ()
//        }
    }
    
    func fetch(id: [String]) {
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
