//
//  UserAuth.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 09/12/23.
//

import Foundation

struct UserAuth: Codable {
    var idToken: String
    var refreshToken: String
    var expires: Double = 0.0
    var tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case idToken = "acces_token"
        case refreshToken = "refresh_token"
        case expires = "expires"
        case tokenType = "token_type"
    }
}
