//
//  RealmFavoriteCoin.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/29/24.
//

import Foundation
import RealmSwift

final class FavoriteCoin: Object {
    @Persisted(primaryKey: true) var id: String
    
    convenience init(id: String) {
        self.init()
        self.id = id
    }
}
