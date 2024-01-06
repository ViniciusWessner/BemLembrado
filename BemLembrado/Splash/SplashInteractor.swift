//
//  SplashInteractor.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 11/12/23.
//

import Foundation
import Combine

class SplashInteractor {
    
    private let remote: SplashRemoteDataSource = .shred
    private let local: LocalDataSource = .shared
}

extension SplashInteractor {

    func fetchAuth() -> Future<UserAuth?, Never> {
        local.getUserAuth()
    }
    
    func insertAuth(userAuth: UserAuth) {
        local.insertUserAuth(userAuth: userAuth)
    }
    
    func refreshToken(refreshRequest request: RefreshRequest) -> Future<SignInResponse, AppError> {
       return remote.refreshToken(request: request)
    }
}
