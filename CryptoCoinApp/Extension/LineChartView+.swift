//
//  LineChartView+.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 5/22/24.
//

import UIKit
import DGCharts

extension LineChartView {
    static func setLineChart(chartView: LineChartView, data: [Double]){
        var entryList: [ChartDataEntry] = []
        for i in 0..<data.count {
            let entry = ChartDataEntry(x: Double(i), y: data[i])
            entryList.append(entry)
        }
        let set = LineChartDataSet(entries: entryList)
        let gradientColors = [
            UIColor.backgroundColor.cgColor,
            UIColor.pointColor.cgColor
        ]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        set.fill = LinearGradientFill(gradient: gradient, angle: 90)
        set.fillAlpha = 1
        set.drawFilledEnabled = true
        set.lineWidth = 2
        set.drawCirclesEnabled = false
        set.mode = .cubicBezier
        set.setColor(.pointColor)
        set.drawVerticalHighlightIndicatorEnabled = false
        set.drawHorizontalHighlightIndicatorEnabled = false

        chartView.data = LineChartData(dataSet: set)
        chartView.doubleTapToZoomEnabled = false
        chartView.xAxis.enabled = false
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        chartView.legend.enabled = false
    }
}
