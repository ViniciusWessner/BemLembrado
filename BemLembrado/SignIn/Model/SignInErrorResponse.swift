//
//  SignInErrorResponse.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 16/11/23.
//

import Foundation

struct SignInErrorResponse: Decodable {
    let detail: SignInDetailErrorResponse
    
    
enum CodingKeys: String, CodingKey {
    case detail
    
    }
}

struct SignInDetailErrorResponse: Decodable {
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message
        
    }
}
