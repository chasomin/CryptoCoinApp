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
        inputNetworkTrigger.bind { [weak self] _ in
            guard let self else { return }
            guard let id = id else { return }
            fetch(id: id)
            Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { _ in
                self.fetch(id: id)
            }
            // TODO: 10초마다 패치하긴 하는데 최신 데이터를 안가져옴
        }
        inputFavoriteButtonTapped.bind { [weak self] value in
            guard let self else { return }
            guard value != nil else { return }
            guard let data = outputData.value else { return }
            outputFavoriteButtonTapped.value = self.saveOrDeleteItem(data.id)
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
            repository.deleteItem(id)
            return "즐겨찾기에서 삭제됐어요"
        }
    }
    
    func fetch(id: String) {
        APIService.shared.fetchCoinMarketAPI(api: .market(id: [id])) { [weak self] data, error in
            guard let self else { return }
            if error != nil {
                outputError.value = error!.rawValue
            } else {
                guard let data = data?.first else { return }
                outputData.value = data
                outputSparkline.value = data.sparkline.price
                outputTextColor.value = textColorSet(data.priceChangePercentage)
            }
        }

    }
}
