//
//  TrendingFavoriteCollectionViewCell.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 3/1/24.
//

import UIKit
import SnapKit
import DGCharts

final class TrendingFavoriteCollectionViewCell: BaseCollectionViewCell {

    let iconNameSymbolView = IconNameSymbolView()
    let priceLabel = UILabel()
    let percentageLabel = UILabel()
    let chartView = LineChartView()

    override func configureHierarchy() {
        contentView.addSubview(iconNameSymbolView)
        contentView.addSubview(chartView)
        contentView.addSubview(percentageLabel)
        contentView.addSubview(priceLabel)
    }
    
    override func configureLayout() {
        iconNameSymbolView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(15)
        }
        chartView.snp.makeConstraints { make in
            make.top.equalTo(iconNameSymbolView.snp.bottom)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(chartView.snp.bottom)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(15)
            make.height.equalTo(18)
        }
        percentageLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom)
            make.horizontalEdges.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(15)
            make.height.equalTo(18)
        }
    }
    
    override func configureView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = .secondaryBackgroundColor
        iconNameSymbolView.nameLabel.textColor = .labelColor
        iconNameSymbolView.symbolLabel.textColor = .secondaryLabel
        priceLabel.textColor = .labelColor
        percentageLabel.textAlignment = .left
        percentageLabel.font = .boldCaption
    }
    
    func configureCell(data: Market) {
        percentageLabel.textColor = HighLowColorManager.shared.setLabelColor(num: data.priceChangePercentage)
        iconNameSymbolView.iconImageView.kf.setImage(with: URL(string: data.image))
        iconNameSymbolView.nameLabel.text = data.name
        iconNameSymbolView.symbolLabel.text = data.symbol
        priceLabel.text = data.priceString
        percentageLabel.text = data.changePercentageString
        LineChartView.setLineChart(chartView: chartView, data: data.sparkline.price)
    }
}
