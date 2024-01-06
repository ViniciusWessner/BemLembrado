//
//  HabitDetailRemoteDataSource.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 28/12/23.
//

import Foundation
import Combine

class HabitDetailRemoteDataSource {
    // padrao singleton - SOMENTE 1 UNICO OBJETO VIVO NO APP
    
    static var shared: HabitDetailRemoteDataSource = HabitDetailRemoteDataSource()
    
    private init(){
    }
    
    func save(habitId: Int, request: HabitValueRequest) -> Future<Bool, AppError> {
        return Future<Bool, AppError> { Promise in
            let path = String(format: WebService.Endpoint.habitValues.rawValue, habitId)
            
            WebService.call(path: path, method: .post, body: request) {result in
                switch result {
                case .failure(_, let data):
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(SignInErrorResponse.self, from: data)
//                            completion(nil, response)
                        Promise(.failure(AppError.response(message: response?.detail.message ?? "Erro desconhecido")))
                        }
                    break
                case .success (_):
                    Promise(.success(true))
                    
                    break
                    
                }
            }
        }
    }
    
}
