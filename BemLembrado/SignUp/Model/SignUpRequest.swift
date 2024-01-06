//
//  SignUpRequest.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 07/11/23.
//

import Foundation

struct SignUpRequest : Encodable {
    
    let fullName: String
    let email: String
    let password: String
    let document: String
    let phone: String
    let birthday: String
    let gender: Int
    
    
    //aqui mapeamos todos os casos
    enum CodingKeys: String, CodingKey {
        case fullName = "name"
        case email
        case password
        case document
        case phone
        case birthday
        case gender
    }
}
