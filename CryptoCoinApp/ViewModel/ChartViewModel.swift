//
//  ChartViewModel.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/28/24.
//

import Foundation

final class ChartViewModel {
    let inputNetworkTrigger: Observable<Void?> = Observable(nil)
    var id: String? = nil
    let outputData: Observable<Market?> = Observable(nil)
    let outputSparkline: Observable<[Double]> = Observable([])
    let outputError: Observable<String?> = Observable(nil)
    let outputTextColor: Observable<Bool?> = Observable(nil)
    
    init() {
        inputNetworkTrigger.bind { _ in
            guard let id = self.id else { return }
            APIService.shared.fetchCoinMarketAPI(api: .market(id: id)) { data, error in
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
    }
    
    private func textColorSet(_ num: Double) -> Bool{
        if num >= 0 { //???: 0% 변동이면 무슨 색이지
            return true
        } else {
            return false
        }
    }
          
}
