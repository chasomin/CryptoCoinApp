//
//  EmptyView.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 3/3/24.
//

import UIKit
import SnapKit

class EmptyView: BaseView {
    let imageView = UIImageView()
    let label = UILabel()
    
    override func configureHierarchy() {
        addSubview(imageView)
        addSubview(label)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
        }
    }
    
    override func configureView() {
        imageView.image = .bookmark
        label.text = "즐겨 찾는 Coin을 저장해보세요!"
        label.font = .boldTitle
        label.textColor = .pointColor
        label.textAlignment = .center
    }
}
