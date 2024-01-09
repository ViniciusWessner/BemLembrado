//
//  ProfileRequest.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 07/01/24.
//

import Foundation

struct ProfileRequest : Encodable {
    
    let fullName: String
    let phone: String
    let birthday: String
    let gender: Int
    
    
    //aqui mapeamos todos os casos
    enum CodingKeys: String, CodingKey {
        case fullName = "name"
        case phone
        case birthday
        case gender
    }
}
