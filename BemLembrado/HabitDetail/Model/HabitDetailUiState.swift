//
//  HabitDetailUiState.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 27/12/23.
//

import Foundation

enum HabitDetailUiState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
