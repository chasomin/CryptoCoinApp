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

        viewModel.outputData.bind { market in
            guard let data = market else { return }
            self.iconNameView.iconImageView.kf.setImage(with: URL(string: data.image))
            self.iconNameView.nameLabel.text = data.name
            self.priceLabel.text = data.priceString
            self.percentageLabel.text = data.changePercentageString
            self.highLabel.text = data.highString
            self.lowLabel.text = data.lowString
            self.allTimeHighLabel.text = data.allTimeHighString
            self.allTimeLowLabel.text = data.allTimeLowString
            self.updateLabel.text = data.update
            self.favoriteButton.image = SetButtonToggleColor.shared.setColor(id: data.id)
        }
        viewModel.outputSparkline.bind { sparkline in
            self.setLineChart(chartView: self.chartView, data: sparkline)
        }
        viewModel.outputError.bind { text in
            guard let text else { return }
            self.showToast(text: text)
        }
        viewModel.outputTextColor.bind { value in
            guard let value else { return }
            self.setTextColor(value)
        }
        viewModel.outputFavoriteButtonTapped.bind { value in
            guard let value else { return }
            self.showToast(text: value)
            guard let data = self.viewModel.outputData.value else { return }
            self.favoriteButton.image = SetButtonToggleColor.shared.setColor(id: data.id)
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
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(iconNameView.snp.bottom).offset(15)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(15)
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
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
        allTimeHStack.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.top.equalTo(highLowHStack.snp.bottom).offset(15)
        }
        chartView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(allTimeHStack.snp.bottom).offset(15)
        }
        updateLabel.snp.makeConstraints { make in
            make.top.equalTo(chartView.snp.bottom)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(15)
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
        
        lowVStack.axis = .vertical
        lowVStack.spacing = 10
        lowVStack.distribution = .fillEqually
        
        allTimeHighVStack.axis = .vertical
        allTimeHighVStack.spacing = 10
        allTimeHighVStack.distribution = .fillEqually
        
        allTimeLowVStack.axis = .vertical
        allTimeLowVStack.spacing = 10
        allTimeLowVStack.distribution = .fillEqually
        
        highLowHStack.axis = .horizontal
        highLowHStack.spacing = 10
        highLowHStack.distribution = .fillEqually
        
        allTimeHStack.axis = .horizontal
        allTimeHStack.spacing = 10
        allTimeHStack.distribution = .fillEqually
        
        favoriteButton.target = self
        favoriteButton.action = #selector(favoriteButtonTapped)
        
        priceLabel.font = .largeTitle
        priceLabel.textColor = .titleColor
        percentageLabel.font = .body
        todayLabel.font = .body
        todayLabel.textColor = .secondaryLabelColor
        highTitleLabel.font = .boldTitle
        highTitleLabel.textColor = .upperLabelColor
        lowTitleLabel.font = .boldTitle
        lowTitleLabel.textColor = .lowerLabelColor
        allTimeHighTitleLabel.font = .boldTitle
        allTimeHighTitleLabel.textColor = .upperLabelColor
        allTimeLowTitleLabel.font = .boldTitle
        allTimeLowTitleLabel.textColor = .lowerLabelColor
        highLabel.font = .title
        highLabel.textColor = .labelColor
        lowLabel.font = .title
        lowLabel.textColor = .labelColor
        allTimeHighLabel.font = .title
        allTimeHighLabel.textColor = .labelColor
        allTimeLowLabel.font = .title
        allTimeLowLabel.textColor = .labelColor
        updateLabel.font = .body
        updateLabel.textColor = .secondaryLabelColor

    }
}

extension ChartViewController {
    func setLineChart(chartView: LineChartView, data: [Double]){
        var entryList: [ChartDataEntry] = []
        for i in 0..<data.count {
            let entry = ChartDataEntry(x: Double(i), y: data[i])
            entryList.append(entry)
        }
        let set = LineChartDataSet(entries: entryList)
        let gradientColors = [ChartColorTemplates.colorFromString("#FFFFFF").cgColor,
                              ChartColorTemplates.colorFromString("#914CF5").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        set.fill = LinearGradientFill(gradient: gradient, angle: 90)
        set.fillAlpha = 1
        set.drawFilledEnabled = true
        set.lineWidth = 2
        set.drawCirclesEnabled = false
        set.mode = .cubicBezier
        set.setColor(.pointColor)
        
        chartView.data = LineChartData(dataSet: set)
        chartView.doubleTapToZoomEnabled = false
        chartView.xAxis.enabled = false
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        chartView.legend.enabled = false
    }

    func setTextColor(_ value: Bool) {
        if value {
            percentageLabel.textColor = .upperLabelColor
        } else {
            percentageLabel.textColor = .lowerLabelColor
        }
    }
    
    @objc func favoriteButtonTapped() {
        viewModel.inputFavoriteButtonTapped.value = ()
    }

}
