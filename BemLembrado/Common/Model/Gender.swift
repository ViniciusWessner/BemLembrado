//
//  Gender.swift
//  Habitos
//
//  Created by Vinicius Wessner on 25/10/23.
//

import Foundation

enum Gender: String, CaseIterable, Identifiable {
    case male = "Masculino"
    case female = "Feminino"
    
    var id: String{
        self.rawValue
    }
    
    var index: Self.AllCases.Index {
        return Self.allCases.firstIndex{self == $0} ?? 0
    }
}
