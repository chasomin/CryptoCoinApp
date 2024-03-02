//
//  TrendingFavoriteCollectionViewCell.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 3/1/24.
//

import UIKit
import SnapKit

final class TrendingFavoriteCollectionViewCell: BaseCollectionViewCell {

    let iconNameSymbolView = IconNameSymbolView()
    let priceLabel = UILabel()
    let percentageLabel = UILabel()

    override func configureHierarchy() {
        contentView.addSubview(iconNameSymbolView)
        contentView.addSubview(percentageLabel)
        contentView.addSubview(priceLabel)
    }
    
    override func configureLayout() {
        iconNameSymbolView.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView.safeAreaLayoutGuide).inset(15)
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
        iconNameSymbolView.nameLabel.textColor = .labelColor
        iconNameSymbolView.symbolLabel.textColor = .secondaryLabel
        priceLabel.textColor = .labelColor
        percentageLabel.textAlignment = .center
        percentageLabel.font = .boldCaption
    }
    
    func configureCell(data: Market) {
        percentageLabel.textColor = HighLowColorManager.shared.setLabelColor(num: data.priceChangePercentage)
        iconNameSymbolView.iconImageView.kf.setImage(with: URL(string: data.image))
        iconNameSymbolView.nameLabel.text = data.name
        iconNameSymbolView.symbolLabel.text = data.symbol
        priceLabel.text = data.priceString
        percentageLabel.text = data.changePercentageString
    }
}
