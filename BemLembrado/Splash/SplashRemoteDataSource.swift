//
//  SplashRemoteDataSource.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 12/12/23.
//

import Foundation
import Combine

class SplashRemoteDataSource {
    // padrao singleton - SOMENTE 1 UNICO OBJETO VIVO NO APP
    
    static var shred: SplashRemoteDataSource = SplashRemoteDataSource()
    
    private init(){
    }
    
    func refreshToken(request: RefreshRequest) -> Future<SignInResponse, AppError> {
        return Future<SignInResponse, AppError> { Promise in
            
            WebService.call(path: .refreshToken, method: .put, body: request) {result in
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
