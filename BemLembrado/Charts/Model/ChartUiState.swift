//
//  ChartUiState.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 17/01/24.
//

import Foundation

enum ChartUiState: Equatable {
    case loading
    case emptyChart
    case fullChart
    case error(String)
}
