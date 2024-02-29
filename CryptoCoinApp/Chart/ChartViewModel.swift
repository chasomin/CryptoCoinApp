//
//  ChartViewModel.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/28/24.
//

import Foundation

final class ChartViewModel {
    var id: String? = nil
    let repository = RealmFavoriteCoinRepository()
    
    let inputNetworkTrigger: Observable<Void?> = Observable(nil)
    let inputFavoriteButtonTapped: Observable<Void?> = Observable(nil)
    
    let outputData: Observable<Market?> = Observable(nil)
    let outputSparkline: Observable<[Double]> = Observable([])
    let outputError: Observable<String?> = Observable(nil)
    let outputTextColor: Observable<Bool?> = Observable(nil)
    let outputFavoriteButtonTapped: Observable<String?> = Observable(nil)
    
    init() {
        inputNetworkTrigger.bind { _ in
            guard let id = self.id else { return }
            APIService.shared.fetchCoinMarketAPI(api: .market(id: [id])) { data, error in
                if error != nil {
                    self.outputError.value = "잠시후에 다시 시도해주세요"
                } else {
                    guard let data = data?.first else { return }
                    self.outputData.value = data
                    self.outputSparkline.value = data.sparkline.price
                    self.outputTextColor.value = self.textColorSet(data.priceChangePercentage)
                }
            }
        }
        inputFavoriteButtonTapped.bind { value in
            guard let value else { return }
            guard let data = self.outputData.value else { return }
            self.outputFavoriteButtonTapped.value = self.saveOrDeleteItem(data.id)
        }
    }
    
    private func textColorSet(_ num: Double) -> Bool{
        if num >= 0 {
            return true
        } else {
            return false
        }
    }
    
    func saveOrDeleteItem(_ id: String) -> String {
        if repository.fetchItem().filter({$0.id == id}).isEmpty {
            if repository.fetchItem().count < 10 {
                repository.createItem(id)
                return "즐겨찾기에 저장됐어요"
            } else {
                return "10개까지만 저장할 수 있어요"
            }
        } else {
            repository.deleteItme(id)
            return "즐겨찾기에서 삭제됐어요"
        }
    }
}
