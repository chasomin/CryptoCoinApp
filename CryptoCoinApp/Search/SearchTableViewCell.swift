//
//  SearchTableViewCell.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/27/24.
//

import UIKit
import SnapKit

final class SearchTableViewCell: BaseTableViewCell {
    let iconImageView = UIImageView()
    let nameLabel = UILabel()
    let symbolLabel = UILabel()
    let favoriteButton = UIButton()
    

    override func configureHierarchy() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(favoriteButton)
    }
    
    override func configureLayout() {
        iconImageView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalTo(contentView.safeAreaLayoutGuide).inset(15)
            make.width.height.equalTo(45)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView)
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
        }
        symbolLabel.snp.makeConstraints { make in
            make.bottom.equalTo(iconImageView)
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
        favoriteButton.snp.makeConstraints { make in
            make.height.width.equalTo(45)
            make.verticalEdges.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(15)
            make.leading.equalTo(nameLabel.snp.trailing).offset(10)
        }
        
    }
    
    override func configureView() {
        
        iconImageView.contentMode = .scaleAspectFill
        
        nameLabel.textColor = .titleColor
        nameLabel.numberOfLines = 1
        nameLabel.textAlignment = .left
        nameLabel.font = .boldBody
        
        symbolLabel.textColor = .secondaryLabel
        symbolLabel.numberOfLines = 1
        symbolLabel.textAlignment = .left
        symbolLabel.font = .caption
        
        
        favoriteButton.setImage(.btnStar, for: .normal)
    }

    func configureCell(data: Item) {
        nameLabel.text = data.name
        symbolLabel.text = data.symbol
        iconImageView.kf.setImage(with: URL(string: data.thumb))
        
    }
}
