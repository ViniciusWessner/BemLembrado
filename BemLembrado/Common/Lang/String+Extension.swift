//
//  String+Extension.swift
//  Habitos
//
//  Created by Vinicius Wessner on 06/11/23.
//

import Foundation

extension String{
    
    func characterAtIndex(index: Int) -> Character? {
        var cur = 0
        for char in self {
            if cur == index {
                return char
            }
            cur = cur + 1
        }
        return nil
    }
    
    
    func isEmail() -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", regEx).evaluate(with: self)
    }
    
    func toDate(sourcePattern source: String, destPattern dest: String) -> String? {
        
        //pegando a string -> e transformando ela em dd/MM/yyyy
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = source
        
        //pegando dd/MM/yyyy e formatando para o tipo DATE
        let dateFormatted = formatter.date(from: self)
        
        //validamos se a data que foi escrita estava nos padroes dd/MM/yyyy
        guard let dateFormatted = dateFormatted else{
            return nil
        }
        
        // inveremos a data para o padrao que a API solicita
        formatter.dateFormat = dest
        return formatter.string(from: dateFormatted)
        
    }
    
    func toDate(sourcePattern source: String) -> Date? {
        
        //pegando a string -> e transformando ela em dd/MM/yyyy
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = source
        
        return formatter.date(from: self)
    }
}



