//
//  RankCollectionViewCell.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 3/1/24.
//

import UIKit
import SnapKit
import Kingfisher

final class RankCollectionViewCell: BaseCollectionViewCell {
    
    let rankLabel = UILabel()
    let iconNameSymbolView = IconNameSymbolView()
    let priceLabel = UILabel()
    let percentageLabel = UILabel()

    override func configureHierarchy() {
        contentView.addSubview(rankLabel)
        contentView.addSubview(iconNameSymbolView)
        contentView.addSubview(priceLabel)
        contentView.addSubview(percentageLabel)
    }
    
    override func configureLayout() {
        rankLabel.snp.makeConstraints { make in
            make.leading.verticalEdges.equalTo(contentView).inset(10)
            make.width.equalTo(25)
        }
        iconNameSymbolView.snp.makeConstraints { make in
            make.leading.equalTo(rankLabel.snp.trailing).offset(10)
            make.centerY.equalTo(contentView)
            make.width.equalTo(170)
        }
        priceLabel.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).inset(10)
            make.top.equalTo(iconNameSymbolView.snp.top)
            make.leading.equalTo(iconNameSymbolView.snp.trailing).offset(10)
        }
        percentageLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(5)
            make.bottom.equalTo(iconNameSymbolView.snp.bottom)
            make.trailing.equalTo(contentView).inset(10)
        }
    }
    
    override func configureView() {
        rankLabel.font = .boldTitle
        rankLabel.textColor = .labelColor
        rankLabel.textAlignment = .center
        
        iconNameSymbolView.nameLabel.textColor = .labelColor
        iconNameSymbolView.symbolLabel.textColor = .labelColor
        
        priceLabel.font = .body
        priceLabel.textColor = .labelColor
        priceLabel.textAlignment = .right
        
        percentageLabel.font = .caption
        percentageLabel.textAlignment = .right
        
    }
}

extension RankCollectionViewCell {
    func configureCell(item: Item, index: Int) {
        rankLabel.text = "\(index + 1)"
        iconNameSymbolView.iconImageView.kf.setImage(with: URL(string: item.small))
        iconNameSymbolView.nameLabel.text = item.name
        iconNameSymbolView.symbolLabel.text = item.symbol
        priceLabel.text = item.data.priceText
        percentageLabel.text = item.data.priceChangePercentage.krw.decimalCalculator()
        percentageLabel.textColor = HighLowColorManager.shared.setLabelColor(num: item.data.priceChangePercentage.krw)
    }
    
    func configureCell(item: NFT, index: Int) {
        rankLabel.text = "\(index + 1)"
        iconNameSymbolView.iconImageView.kf.setImage(with: URL(string: item.thumb))
        iconNameSymbolView.nameLabel.text = item.name
        iconNameSymbolView.symbolLabel.text = item.symbol
        priceLabel.text = item.data.floorPrice
        percentageLabel.text = item.data.floorPriceChangePercentage.decimalCalculator()
        percentageLabel.textColor = HighLowColorManager.shared.setLabelColor(num: item.data.floorPriceChangePercentage)

    }
}
