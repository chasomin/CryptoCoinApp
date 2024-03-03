//
//  IconNameSymbolView.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 3/1/24.
//

import UIKit

class IconNameSymbolView: UIView {
    let iconImageView = UIImageView()
    let nameLabel = UILabel()
    let symbolLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(iconImageView)
        addSubview(nameLabel)
        addSubview(symbolLabel)

        
        iconImageView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalTo(safeAreaLayoutGuide)
            make.height.width.equalTo(45)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView).inset(5)
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide)
        }
        symbolLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.bottom.equalTo(iconImageView).inset(5)
            make.trailing.equalTo(safeAreaLayoutGuide)
        }

        iconImageView.contentMode = .scaleAspectFill
        
        nameLabel.numberOfLines = 1
        nameLabel.textAlignment = .left
        nameLabel.font = .boldBody
        nameLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        symbolLabel.numberOfLines = 1
        symbolLabel.textAlignment = .left
        symbolLabel.font = .caption
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
