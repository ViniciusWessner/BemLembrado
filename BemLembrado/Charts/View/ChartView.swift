//
//  ChartView.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 08/01/24.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    @ObservedObject var viewModel: ChartViewModel
    
    var body: some View {
 
        BoxChartView(entries: $viewModel.entries, dates: $viewModel.dates)
            .frame(maxWidth: .infinity, maxHeight: 350)
    }
}

#Preview {
    ChartView(viewModel: ChartViewModel())
}
