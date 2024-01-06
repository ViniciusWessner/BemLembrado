//
//  profileResponse.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 04/01/24.
//

import Foundation

struct ProfileResponse : Decodable {
    
    let id: Int
    let fullName: String
    let email: String
    let document: String
    let phone: String
    let birthday: String
    let gender: Int
    
    
    //aqui mapeamos todos os casos
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "name"
        case email
        case document
        case phone
        case birthday
        case gender
    }
}
