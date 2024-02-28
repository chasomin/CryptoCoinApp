//
//  ChartViewModel.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/28/24.
//

import Foundation

class ChartViewModel {
    let inputNetworkTrigger: Observable<Void?> = Observable(nil)
    var id: String = ""
    let outputData: Observable<[Market]> = Observable([])
    
    init() {
        inputNetworkTrigger.bind { _ in
            APIService.shared.fetchCoinMarketAPI(api: .market(id: self.id)) { data, error in
                if error != nil {
                    print("네트워크에러", error)
                } else {
                    guard let data else { return }
                    print(data.count)
                    self.outputData.value = data
                }
            }
        }
    }
          
}
