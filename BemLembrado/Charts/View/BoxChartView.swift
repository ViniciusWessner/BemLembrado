//
//  BoxChartView.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 11/01/24.
//

import SwiftUI
import Charts

struct BoxChartView: UIViewRepresentable {
    typealias UIViewType = LineChartView
    
    @Binding var entries: [ChartDataEntry]
    @Binding var dates: [String]
    
    func makeUIView(context: Context) -> LineChartView {
        let uiView = LineChartView()
        
        uiView.legend.enabled = false
        uiView.chartDescription?.enabled = false
        uiView.xAxis.granularity = 1
        uiView.xAxis.labelPosition = .bottom
        uiView.rightAxis.enabled = false
        uiView.xAxis.valueFormatter = DateAxisValueFormatter(dates: dates)
        uiView.leftAxis.axisLineColor = .cordologo
        uiView.animate(yAxisDuration: 2.0)
        
        uiView.data = addData()
        
        return uiView
    }
    
    private func addData() -> LineChartData {
        
        let colors = [UIColor.white.cgColor, UIColor.cordologo.cgColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        guard let gradient = CGGradient(colorsSpace: colorSpace,
                   colors: colors as CFArray,
                locations: colorLocations)
        else {return LineChartData(dataSet: nil)}
        
        let dataSet = LineChartDataSet(entries: entries, label: "")
        
        dataSet.mode = .cubicBezier
        dataSet.lineWidth = 2
        dataSet.circleRadius = 4
        dataSet.setColor(.cordologo)
        dataSet.drawFilledEnabled = true
        dataSet.circleColors = [.cordologoligth]
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        dataSet.drawVerticalHighlightIndicatorEnabled = false
        dataSet.fill = Fill(linearGradient: gradient, angle: 90.0)
        
        return LineChartData(dataSet: dataSet)
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        
    }
}


class DateAxisValueFormatter: IAxisValueFormatter {
    
    let dates: [String]
    
    init(dates: [String]){
        self.dates = dates
    }
    
    func stringForValue(_ value: Double, axis: Charts.AxisBase?) -> String {
        let position = Int(value)
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "yyyy-MM-dd"
        
        
        if position > 0 && position < dates.count {
            let date = df.date(from: dates[position])
            let df = DateFormatter()
            
            guard let date = date else {
                return ""
            }
            
            df.dateFormat = "dd/MM"
            let createdAt = df.string(from: date)
            //retornando a data
            return createdAt
        } else {
            return ""
        }
        
    }
}

#Preview {
    BoxChartView(entries: .constant([
        ChartDataEntry(x: 2.0, y: 3.3),
        ChartDataEntry(x: 5.0, y: 5.3),
        ChartDataEntry(x: 7.0, y: 7.3),
        ]),dates: .constant([
            "01/02/2024",
            "02/02/2024",
            "03/02/2024",
        ]))
    .frame(maxWidth: .infinity, maxHeight: 350)
}
