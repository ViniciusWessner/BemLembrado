//
//  ChartViewModel.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 11/01/24.
//

import Foundation
import SwiftUI
import Charts

class ChartViewModel: ObservableObject {
    
    @Published var entries: [ChartDataEntry] = [
        ChartDataEntry(x: 1.0, y: 2.0),
        ChartDataEntry(x: 2.0, y: 5.0),
        ChartDataEntry(x: 3.0, y: 6.0),
        ChartDataEntry(x: 4.0, y: 8.0),
        ChartDataEntry(x: 5.0, y: 2.0),
        ChartDataEntry(x: 6.0, y: 5.0),
        ChartDataEntry(x: 7.0, y: 3.0),
        ChartDataEntry(x: 8.0, y: 12.0),
        ChartDataEntry(x: 9.0, y: 6.0),
        ChartDataEntry(x: 10.0, y: 3.0),
    ]
    
    @Published var dates = [
        "2024-01-01",
        "2024-01-02",
        "2024-01-03",
        "2024-01-04",
        "2024-01-05",
        "2024-01-06",
        "2024-01-07",
        "2024-01-08",
        "2024-01-09",
        "2024-01-10",

    ]
    
}
