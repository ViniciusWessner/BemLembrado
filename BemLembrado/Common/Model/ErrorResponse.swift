//
//  ErrorResponse.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 16/11/23.
//

import Foundation

struct ErrorResponse: Decodable {
    let detail: String
    
    

enum CodingKeys: String, CodingKey {
    case detail
    
    }
}
