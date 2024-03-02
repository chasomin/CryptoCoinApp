//
//  Alert+Extension.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 3/3/24.
//

import UIKit

extension UIViewController {
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "오류", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(ok)
        alert.view.tintColor = .pointColor
        present(alert, animated: true)
    }
}
