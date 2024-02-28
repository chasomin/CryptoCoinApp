//
//  Number+Extension.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/28/24.
//

import Foundation

extension Int {
    func priceKRWCalculator() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let result = numberFormatter.string(from: self as NSNumber) else { return "0" }
        
        return "₩\(result)"
    }
}

extension Double {
    func decimalCalculator() -> String {
        if self > 0 {
            return String(format: "+%.2f", self) + "%"
        } else {
            return String(format: "%.2f", self) + "%"
        }
    }
}
