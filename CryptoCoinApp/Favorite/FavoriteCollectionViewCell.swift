//
//  FavoriteCollectionViewCell.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/28/24.
//

import UIKit
import SnapKit
import Kingfisher

final class FavoriteCollectionViewCell: BaseCollectionViewCell {
    let iconImageView = UIImageView()
    let nameLabel = UILabel()
    let symbolLabel = UILabel()
    let priceLabel = UILabel()
    let percentageView = UIView()
    let percentageLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(percentageView)
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
            make.trailing.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(25)
            make.height.equalTo(25)
        }
        percentageView.snp.makeConstraints { make in
            make.trailing.equalTo(percentageLabel.snp.trailing).offset(10)
            make.bottom.equalTo(percentageLabel.snp.bottom)
            make.leading.equalTo(percentageLabel.snp.leading).offset(-10)
            make.top.equalTo(percentageLabel.snp.top)
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

        percentageLabel.textAlignment = .center
        percentageLabel.font = .boldCaption
        
        percentageView.layer.cornerRadius = 5
        percentageView.clipsToBounds = true
    }
    
    func configureCell(data: Market) {
        // TODO: label 색 설정
        percentageLabel.textColor = HighLowColorManager.shared.setLabelColor(num: data.priceChangePercentage)
        percentageView.backgroundColor = HighLowColorManager.shared.setBackColor(num: data.priceChangePercentage)
        iconImageView.kf.setImage(with: URL(string: data.image))
        nameLabel.text = data.name
        symbolLabel.text = data.symbol
        priceLabel.text = data.priceString
        percentageLabel.text = data.changePercentageString

    }
}
