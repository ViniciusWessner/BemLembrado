//
//  Date+Extension.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 22/12/23.
//

import Foundation

extension Date {
    func toString(destPattern dest: String) -> String {
        //pegando a string -> e transformando ela em dd/MM/yyyy
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = dest
        
        return formatter.string(from: self)
    }
}
