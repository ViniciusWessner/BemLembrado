//
//  SignUpRemoteDataSource.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 07/12/23.
//

import Foundation
import Combine

class SignUpRemoteDataSource {
    
    static var shred: SignUpRemoteDataSource = SignUpRemoteDataSource()
    
    private init(){
    }
    
    func postUser (request: SignUpRequest) -> Future <Bool, AppError> {
        return Future {promise in
            WebService.call(path: .postUsers,method: .post, body: request) {result in
                switch result {
                case .failure(let error, let data):
                    if let data = data {
                        if error == .badRequest{
                            let decoder = JSONDecoder()
                            let response = try? decoder.decode(ErrorResponse.self, from: data)
                            //completion(nil, response)
                            promise(.failure(AppError.response(message: response?.detail ?? "Erro interno")))
                        }
                    }
                    break
                case .success(_):
                    promise(.success(true))
                    //completion(true, nil)
                    break
                }
            }
            
        }
    }
}
