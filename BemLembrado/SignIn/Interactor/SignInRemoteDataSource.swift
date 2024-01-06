//
//  RemoteDataSource.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 20/11/23.
//

import Foundation
import Combine

class SignInRemoteDataSource {
    // padrao singleton - SOMENTE 1 UNICO OBJETO VIVO NO APP
    
    static var shred: SignInRemoteDataSource = SignInRemoteDataSource()
    
    private init(){
    }
    
    func login(request: SignInRequest) -> Future<SignInResponse, AppError> {
        return Future<SignInResponse, AppError> { Promise in
            
            WebService.call(path: .login, params: [
                URLQueryItem(name: "username",value: request.email),
                URLQueryItem(name: "password",value: request.password)
            ]) {result in
                switch result {
                case .failure(let error, let data):
                    if let data = data {
                        if error == .unauthorized{
                            let decoder = JSONDecoder()
                            let response = try? decoder.decode(SignInErrorResponse.self, from: data)
//                            completion(nil, response)
                            Promise(.failure(AppError.response(message: response?.detail.message ?? "Erro desconhecido")))
                        }
                    }
                    break
                case .success (let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(SignInResponse.self, from: data)
//                    completion(response, nil)
                    guard let response = response else {
                        print("Log: erro de parser \(String(data: data, encoding: .utf8)!)")
                        return
                    }
                    
                    Promise(.success(response))
                    
                    break
                    
                }
            }
        }
    }
    
}
