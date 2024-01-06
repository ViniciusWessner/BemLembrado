//
//  LocaDataSource.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 09/12/23.
//

import Foundation
import Combine

class LocalDataSource {
    
    static var shared: LocalDataSource = LocalDataSource()
    
    private init(){
    }
    
    // vai ser encodado o objeto
    private func saveValue(value: UserAuth) {
        UserDefaults.standard.setValue(try? PropertyListEncoder().encode(value), forKey: "user_key")
    }
    
    //Decodificando o objeto
    private func readValue(forkey key: String) -> UserAuth? {
        var userAuth: UserAuth?
        //aqui vamos tentar converter de volta o objeto
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            userAuth = try? PropertyListDecoder().decode(UserAuth.self, from: data)
        }
        return userAuth
    }
    
}

extension LocalDataSource {
    //funcao que chama a funcao savevalue e espera um parametro
    func insertUserAuth(userAuth: UserAuth) {
        saveValue(value: userAuth)
    }
    
    // aqui vamos conseguir ler caso ele consiga retornar
    func getUserAuth() -> Future<UserAuth?, Never> {
        let userAuth = readValue(forkey: "user_key")
        return Future { promise in
            promise(.success(userAuth))
        }
    }
}
