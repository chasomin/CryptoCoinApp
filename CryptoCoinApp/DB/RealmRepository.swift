//
//  RealmRepository.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/29/24.
//

import Foundation
import RealmSwift

final class RealmFavoriteCoinRepository {
    let realm = try! Realm()
    
    func createItem(_ id: String) {
        let item = FavoriteCoin(id: id)
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
        
    }
    
    func fetchItem() -> [FavoriteCoin] {
        return Array(realm.objects(FavoriteCoin.self))
    }
    
    
    func deleteItme(_ id: String) {
        
        let item = fetchItem().filter{$0.id == id}
        
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print(error)
        }
    }
}