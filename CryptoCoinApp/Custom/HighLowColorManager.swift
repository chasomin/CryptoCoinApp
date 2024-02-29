//
//  HighLowColorManager.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/29/24.
//

import UIKit

final class HighLowColorManager {
    static let shared = HighLowColorManager()
    private init() { }
    
    func setLabelColor(num: Double) -> UIColor {
        if num < 0 {
            return .lowerLabelColor
        } else {
            return .upperLabelColor
        }
    }
    
    func setBackColor(num: Double) -> UIColor {
        if num < 0 {
            return .lowerBackColor
        } else {
            return .upperBackColor
        }
    }
}
