//
//  RefreshRequest.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 12/12/23.
//

import Foundation

struct RefreshRequest : Encodable {
    
    let token: String
    
    
    //aqui mapeamos todos os casos
    enum CodingKeys: String, CodingKey {
        case token = "refresh_token"
    }
}
