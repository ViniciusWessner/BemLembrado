//
//  SplashViewRouter.swift
//  Habitos
//
//  Created by Vinicius Wessner on 24/10/23.
//

import SwiftUI

enum SplashViewRouter{
    
    static func makeSignInView() -> some View {
        let homeViewModel = HomeViewModel()
        
        let viewModel = SignInViewModel(interactor: SignInInteractor(), 
                                        homeViewModel: homeViewModel)
        return SignInView(viewModel: viewModel)
    }
    
    static func makeHomeView() -> some View{
        let viewModel = HomeViewModel()
        return Homeview(viewModel: viewModel)
    }
}
