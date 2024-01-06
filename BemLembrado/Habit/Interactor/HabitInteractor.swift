//
//  HabitInteractor.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 22/12/23.
//

import Foundation
import Combine

class HabitInteractor {
    
    private let remote: HabitRemoteDataSource = .shared
    
}

extension HabitInteractor {
    
    func fetchHabits() -> Future<[HabitResponse], AppError> {
        return remote.fetchHabits()
    }
    
}
