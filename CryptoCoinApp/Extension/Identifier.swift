//
//  Identifier.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/27/24.
//

import UIKit

extension UITableViewCell {
    static var id: String {
        self.description()
    }
}

extension UICollectionViewCell {
    static var id: String {
        self.description()
    }
}
