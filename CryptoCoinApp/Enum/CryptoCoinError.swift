//
//  CryptoCoinError.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 3/3/24.
//

import Foundation

enum CryptoCoinError: String, Error {
    case failNetworking = "오류가 발생했어요\n잠시 후에 다시 시도해주세요"
    case failConnectDB = "업데이트 실패\n잠시 후에 다시 시도해주세요"
}
