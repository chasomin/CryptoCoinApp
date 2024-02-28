//
//  ChartViewController.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/28/24.
//

import UIKit
import DGCharts
import Kingfisher

final class ChartViewController: BaseViewController {
    let viewModel = ChartViewModel()
    
    let favoriteButton = UIBarButtonItem()
    let iconNameView = IconNameView()

    let priceLabel = UILabel()
    let percentageLabel = UILabel()
    let todayLabel = UILabel()
    let highTitleLabel = UILabel()
    let highLabel = UILabel()
    let lowTitleLabel = UILabel()
    let lowLabel = UILabel()
    let allTimeHighTitleLabel = UILabel()
    let allTimeHighLabel = UILabel()
    let allTimeLowTitleLabel = UILabel()
    let allTimeLowLabel = UILabel()
    let updateLabel = UILabel()

    let highVStack = UIStackView()
    let lowVStack = UIStackView()
    let allTimeHighVStack = UIStackView()
    let allTimeLowVStack = UIStackView()
    
    let highLowHStack = UIStackView()
    let allTimeHStack = UIStackView()
    
    let chartView = LineChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = favoriteButton
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        viewModel.inputNetworkTrigger.value = ()

        viewModel.outputData.bind { marketList in
            guard let data = marketList.first else { return }
            self.iconNameView.iconImageView.kf.setImage(with: URL(string: data.image))
            self.iconNameView.nameLabel.text = data.name
            self.priceLabel.text = "₩\(data.currentPrice)"
            self.percentageLabel.text = "\(data.priceChangePercentage)"
            self.highLabel.text = "\(data.high)"
            self.lowLabel.text = "\(data.low)"
            self.allTimeHighLabel.text = "\(data.allTimeHigh)"
            self.allTimeLowLabel.text = "\(data.allTimeLow)"
            self.updateLabel.text = data.lastUpdated
            //TODO: number Formatter, String 처리
        }
    }
    
    override func configureHierarchy() {
        [iconNameView, priceLabel, percentageLabel, todayLabel, highLowHStack, allTimeHStack, chartView, updateLabel].forEach {
            view.addSubview($0)
        }
        [highVStack, lowVStack].forEach {
            highLowHStack.addArrangedSubview($0)
        }
        [allTimeHighVStack, allTimeLowVStack].forEach {
            allTimeHStack.addArrangedSubview($0)
        }
        [highTitleLabel, highLabel].forEach {
            highVStack.addArrangedSubview($0)
        }
        [lowTitleLabel, lowLabel].forEach {
            lowVStack.addArrangedSubview($0)
        }
        [allTimeHighTitleLabel, allTimeHighLabel].forEach {
            allTimeHighVStack.addArrangedSubview($0)
        }
        [allTimeLowTitleLabel, allTimeLowLabel].forEach {
            allTimeLowVStack.addArrangedSubview($0)
        }
    }
    
    override func configureLayout() {

        iconNameView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(iconNameView.snp.bottom).offset(15)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        percentageLabel.snp.makeConstraints { make in
            make.leading.equalTo(priceLabel)
            make.top.equalTo(priceLabel.snp.bottom).offset(10)
        }
        todayLabel.snp.makeConstraints { make in
            make.leading.equalTo(percentageLabel.snp.trailing).offset(10)
            make.top.bottom.equalTo(percentageLabel)
        }
        highLowHStack.snp.makeConstraints { make in
            make.top.equalTo(percentageLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        allTimeHStack.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(highLowHStack.snp.bottom).offset(15)
        }
        chartView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(allTimeHStack.snp.bottom).offset(15)
        }
        updateLabel.snp.makeConstraints { make in
            make.top.equalTo(chartView.snp.bottom)
            make.trailing.equalTo(chartView)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        
        self.todayLabel.text = "Today"
        self.highTitleLabel.text = "고가"
        self.lowTitleLabel.text = "저가"
        self.allTimeHighTitleLabel.text = "신고점"
        self.allTimeLowTitleLabel.text = "신저점"

        highVStack.axis = .vertical
        highVStack.spacing = 10
        highVStack.distribution = .fillEqually
        highVStack.backgroundColor = .red
        
        lowVStack.axis = .vertical
        lowVStack.spacing = 10
        lowVStack.distribution = .fillEqually
        lowVStack.backgroundColor = .blue
        
        allTimeHighVStack.axis = .vertical
        allTimeHighVStack.spacing = 10
        allTimeHighVStack.distribution = .fillEqually
        allTimeHighVStack.backgroundColor = .red
        
        allTimeLowVStack.axis = .vertical
        allTimeLowVStack.spacing = 10
        allTimeLowVStack.distribution = .fillEqually
        allTimeLowVStack.backgroundColor = .blue
        
        highLowHStack.axis = .horizontal
        highLowHStack.spacing = 10
        highLowHStack.distribution = .fillEqually

        allTimeHStack.axis = .horizontal
        allTimeHStack.spacing = 10
        allTimeHStack.distribution = .fillEqually

        favoriteButton.image = .btnStar
        favoriteButton.target = self
        favoriteButton.action = #selector(favoriteButtonTapped)
        
        priceLabel.font = .largeTitle
        percentageLabel.font = .body
        todayLabel.font = .body
        highTitleLabel.font = .boldTitle
        lowTitleLabel.font = .boldTitle
        allTimeHighTitleLabel.font = .boldTitle
        allTimeLowTitleLabel.font = .boldTitle
        highLabel.font = .title
        lowLabel.font = .title
        allTimeHighLabel.font = .title
        allTimeLowLabel.font = .title
        updateLabel.font = .body
    }
    
    @objc func favoriteButtonTapped() {
        
    }


}
