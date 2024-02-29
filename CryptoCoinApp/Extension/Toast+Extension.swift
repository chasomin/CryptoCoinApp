//
//  Toast+Extension.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/27/24.
//

import UIKit
import Toast

extension UIViewController {
    func showToast(text: String) {
        var style = ToastStyle()
        style.backgroundColor = .pointColor
        style.messageColor = .white
        style.verticalPadding = 15
        style.horizontalPadding = 20
        style.messageFont = .boldBody
        self.view.makeToast(text, duration: 2, position: .center, style: style)
    }
}
