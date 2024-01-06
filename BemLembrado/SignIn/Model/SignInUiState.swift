//
//  SignInUiState.swift
//  Habitos
//
//  Created by Vinicius Wessner on 25/10/23.
//

import Foundation

enum SignInUiState: Equatable{
    case none
    case loading
    case goToHomeScreen
    case error(String)
}
