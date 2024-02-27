//
//  FavoriteCollectionViewCell.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/28/24.
//

import UIKit
import SnapKit

class FavoriteCollectionViewCell: BaseCollectionViewCell {
    let iconImageView = UIImageView()
    let nameLabel = UILabel()
    let symbolLabel = UILabel()
    let priceLabel = UILabel()
    let percentageLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(percentageLabel)
        contentView.addSubview(priceLabel)
    }
    
    override func configureLayout() {
        iconImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView.safeAreaLayoutGuide).inset(15)
            make.height.width.equalTo(45)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView)
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(15)
        }
        symbolLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.bottom.equalTo(iconImageView)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(15)
        }
        percentageLabel.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(15)
            make.width.equalTo(75)
            make.height.equalTo(25)
        }
        priceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(percentageLabel.snp.top)
            make.height.equalTo(30)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(15)
        }
    }
    
    override func configureView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 20
        
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 0)

        iconImageView.contentMode = .scaleAspectFill
        
        nameLabel.textColor = .labelColor
        nameLabel.numberOfLines = 1
        nameLabel.textAlignment = .left
        nameLabel.font = .boldBody
        
        symbolLabel.textColor = .secondaryLabel
        symbolLabel.numberOfLines = 1
        symbolLabel.textAlignment = .left
        symbolLabel.font = .caption

        priceLabel.textColor = .labelColor
        priceLabel.numberOfLines = 1
        priceLabel.textAlignment = .right
        priceLabel.font = .boldBody

        percentageLabel.textColor = .upperLabelColor // -+다르게
        percentageLabel.textAlignment = .center
        percentageLabel.font = .boldCaption
        percentageLabel.layer.cornerRadius = 5
        percentageLabel.clipsToBounds = true
        percentageLabel.backgroundColor = .upperBackColor   // -+다르게
    }
}
