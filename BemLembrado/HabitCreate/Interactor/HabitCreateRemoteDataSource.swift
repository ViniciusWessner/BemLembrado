//
//  RemoteDataSource.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 21/01/24.
//

import Foundation
import Combine

class HabitCreateRemoteDataSource {
    // padrao singleton - SOMENTE 1 UNICO OBJETO VIVO NO APP
    
    static var shred: HabitCreateRemoteDataSource = HabitCreateRemoteDataSource()
    
    private init(){
    }
    
    func save(request: HabitCreateRequest) -> Future<Void, AppError> {
        return Future<Void, AppError> { promise in
            WebService.call(path: .habits, params: [
                URLQueryItem(name: "name", value: request.name),
                URLQueryItem(name: "label", value: request.label)
            ], data: request.imageData) { result in
                switch result {
                case .failure(let error, let data):
                    if let data = data {
                        if error == .unauthorized {
                            let decoder = JSONDecoder()
                            let response = try? decoder.decode(SignInErrorResponse.self, from: data)
                            // completion(nil, response)
                            
                            promise(.failure(AppError.response(message: response?.detail.message ?? "Erro desconhecido no servidor")))
                        }
                    }
                    break
                case .success(_):
                    promise(.success( () ))
                    
                    break
                }
            }
        }
        
    }
}
