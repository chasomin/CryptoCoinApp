//
//  CircleUserImageBarButton.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 3/3/24.
//

import UIKit
import SnapKit
import Kingfisher

class CircleUserImageBarButton: BaseView {
    let image = UIImageView()

    override func layoutSubviews() {
        super.layoutSubviews()
        image.layer.cornerRadius = image.frame.width / 2
        image.clipsToBounds = true

    }
    
    override func configureHierarchy() {
        addSubview(image)
    }
    
    override func configureLayout() {
        image.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.width.height.equalTo(40)
        }
        self.snp.makeConstraints { make in
            make.width.height.equalTo(40)
        }
    }
    
    override func configureView() {
        image.layer.borderColor = UIColor.pointColor.cgColor
        image.layer.borderWidth = 3
        image.clipsToBounds = true
        image.kf.setImage(with: URL(string: "https://avatars.githubusercontent.com/u/114223423?v=4"))
    }
}
