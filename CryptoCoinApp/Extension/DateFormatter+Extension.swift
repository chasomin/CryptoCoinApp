//
//  DateFormatter+Extension.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/28/24.
//

import Foundation

extension Date {
    func dateToString() -> String {
        let format = DateFormatter()
        format.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        format.dateFormat = "M/d HH:mm:ss 업데이트"
        return format.string(from: self)
    }
}

extension String {
    func stringDate() -> String {
        let format = DateFormatter()
        format.timeZone = TimeZone(abbreviation: "UTC")
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = format.date(from: self) ?? Date()
        
        print(date)
        return date.dateToString()
    }
}
