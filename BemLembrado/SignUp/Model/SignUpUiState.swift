//
//  SignUpUiState.swift
//  Habitos
//
//  Created by Vinicius Wessner on 25/10/23.
//

import Foundation

enum SignUpUiState: Equatable{
    case none
    case loading
    case success
    case error(String)
}
