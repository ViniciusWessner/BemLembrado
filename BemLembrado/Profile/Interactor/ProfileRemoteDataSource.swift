//
//  ProfileRemoteDataSource.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 04/01/24.
//

import Foundation
import Combine

class ProfileRemoteDataSource {
    
    static var shared: ProfileRemoteDataSource = ProfileRemoteDataSource()
    
    private init(){
    }
    
    func fetchUser () -> Future<ProfileResponse, AppError> {
        return Future {promise in
            WebService.call(path: .fetchUsers,method: .get) {result in
                switch result {
                case .failure(_, let data):
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(ErrorResponse.self, from: data)
                        //completion(nil, response)
                        promise(.failure(AppError.response(message: response?.detail ?? "Erro interno")))
                    }
                    break
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(ProfileResponse.self, from: data)
                    
                    guard let res = response else {
                        print("Log: erro profile remotedatasource \(String(data: data, encoding: .utf8)!)")
                        return
                    }
                    
                    promise(.success(res))
                    //completion(true, nil)
                    break
                }
            }
            
        }
    }
    
    func updateUser(userId: Int, request profileRequest : ProfileRequest) -> Future<ProfileResponse, AppError> {
        return Future {promise in
            let path = String(format: WebService.Endpoint.updateUser.rawValue, userId)
            WebService.call(path: path,method: .put, body: profileRequest) {result in
                switch result {
                case .failure(_, let data):
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(ErrorResponse.self, from: data)
                        //completion(nil, response)
                        promise(.failure(AppError.response(message: response?.detail ?? "Erro interno")))
                    }
                    break
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(ProfileResponse.self, from: data)
                    
                    guard let res = response else {
                        print("Log: erro profile remotedatasource \(String(data: data, encoding: .utf8)!)")
                        return
                    }
                    
                    promise(.success(res))
                    //completion(true, nil)
                    break
                }
            }
            
        }
    }
}
