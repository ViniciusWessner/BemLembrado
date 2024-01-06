//
//  HabitUiState.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 18/12/23.
//

import Foundation

enum HabitUiState: Equatable {
    case loading
    case emptyList
    case fullList([HabitCardViewModel])
    case error(String)
}
