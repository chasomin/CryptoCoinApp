//
//  IconNameView.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/28/24.
//

import UIKit
import SnapKit

class IconNameView: UIView {
    let iconImageView = UIImageView()
    let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(iconImageView)
        addSubview(nameLabel)
        
        iconImageView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview()
            make.width.height.equalTo(50)
        }
        nameLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(iconImageView)
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
        }
        nameLabel.font = .largeTitle
        nameLabel.numberOfLines = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
