//
//  ProfileUiState.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 04/01/24.
//

import Foundation

enum ProfileUiState: Equatable {
    case none
    case loading
    case fetchSuccess
    case fetchError(String)
    
    case updateLoading
    case updateSuccess
    case updateError(String)
}
