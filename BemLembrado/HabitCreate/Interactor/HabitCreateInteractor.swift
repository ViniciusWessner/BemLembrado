//
//  HabitCreateInteractor.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 21/01/24.
//

import Foundation
import Combine

class HabitCreateInteractor {
    private let remote: HabitCreateRemoteDataSource = .shred
}

extension HabitCreateInteractor {
    
    func save(habitCreateRequest request: HabitCreateRequest) -> Future<Void, AppError> {
        return remote.save(request: request)
    }
    
}
