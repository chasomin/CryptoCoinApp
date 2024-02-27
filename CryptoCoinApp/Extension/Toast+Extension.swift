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
        style.backgroundColor = .black
        style.messageColor = .white
        self.view.makeToast(text, duration: 2, position: .center, style: style)
    }
}
