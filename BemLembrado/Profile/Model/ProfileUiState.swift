//
//  ProfileUiState.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 04/01/24.
//

import Foundation

enum ProfileUiState {
    case none
    case loading
    case fetchSuccess
    case fetchError(String)
}
