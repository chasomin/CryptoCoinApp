//
//  TrendingFavoriteCollectionViewCell.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 3/1/24.
//

import UIKit
import SnapKit

final class TrendingFavoriteCollectionViewCell: BaseCollectionViewCell {
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
            make.leading.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(15)
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
        
        contentView.backgroundColor = .secondaryBackgroundColor
        
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
        priceLabel.textAlignment = .left
        priceLabel.font = .boldBody

        percentageLabel.textAlignment = .center
        percentageLabel.font = .boldCaption
        
    }
    
    func configureCell(data: Market) {
        percentageLabel.textColor = HighLowColorManager.shared.setLabelColor(num: data.priceChangePercentage)
        iconImageView.kf.setImage(with: URL(string: data.image))
        nameLabel.text = data.name
        symbolLabel.text = data.symbol
        priceLabel.text = data.priceString
        percentageLabel.text = data.changePercentageString
    }

}
