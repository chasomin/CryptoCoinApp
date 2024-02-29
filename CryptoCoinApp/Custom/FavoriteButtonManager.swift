//
//  UIButton+Extension.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/29/24.
//

import UIKit

class SetButtonToggleColor {
    static let shared = SetButtonToggleColor()
    private init() { }
    
    func setColor(id: String) -> UIImage {
        let repository = RealmFavoriteCoinRepository()
        let idList = repository.fetchItem().map{$0.id}
        if idList.contains(id) {
            return .btnStarFill
        } else {
            return .btnStar
        }
    }
}
