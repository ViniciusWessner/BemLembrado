//
//  ChartRemoteDataSource.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 17/01/24.
//

import Foundation
import Combine

class ChartRemoteDataSource {
    
    static var shared: ChartRemoteDataSource = ChartRemoteDataSource()
    
    private init(){
    }
    
    func fetchHabitValues(habitId: Int) -> Future<[HabitValueResponse], AppError> {
        return Future {promise in
            
            let path = String(format: WebService.Endpoint.habitValues.rawValue, habitId)
            
            WebService.call(path: path, method: .get) {result in
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
                    let response = try? decoder.decode([HabitValueResponse].self, from: data)
                    
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
