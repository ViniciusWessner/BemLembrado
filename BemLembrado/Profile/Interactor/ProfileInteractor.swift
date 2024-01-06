//
//  ProfileInteractor.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 04/01/24.
//

import Foundation
import Combine

class ProfileInteractor {
    
    private let remote: ProfileRemoteDataSource = .shared

}

extension ProfileInteractor {
    
    func fetchUser() -> Future<ProfileResponse, AppError> {
        return remote.fetchUser()
    }
}
