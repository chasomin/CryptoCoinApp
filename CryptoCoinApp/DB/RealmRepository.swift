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
        print(realm.configuration.fileURL)
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
    }
    
    func fetchItem() -> [FavoriteCoin] {
        return Array(realm.objects(FavoriteCoin.self).sorted(byKeyPath: "regDate", ascending: false))
    }
    
    func deleteItem(_ id: String) {
        let item = fetchItem().filter{$0.id == id}
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print(error)
        }
    }
    
    func changeItem(_ id: String, index: Int) {
        do {
            try realm.write {
                realm.create(FavoriteCoin.self,
                             value: ["id":id,
                                     "regDate": Date()],
                             update: .modified)
            }
        } catch {
            print(error)
        }

    }
    
}
