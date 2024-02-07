//
//  SignInViewModel.swift
//  Habitos
//
//  Created by Vinicius Wessner on 22/10/23.
//

import SwiftUI
import Combine

class SignInViewModel: ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    
    private var cancellableRequest: AnyCancellable?
    private var cancellable: AnyCancellable?
    
    private let interactor: SignInInteractor
    private let homeViewModel: HomeViewModel
    var publisher = PassthroughSubject<Bool, Never>()
    
    @Published var uiState: SignInUiState = .none
    
    init(interactor: SignInInteractor, homeViewModel: HomeViewModel){
        self.interactor = interactor
        self.homeViewModel = homeViewModel
        cancellable = publisher.sink { value in
            print("Usuario criado GOTOhome: \(value)")
            
            if value{
                self.uiState = .goToHomeScreen
            }
        }
    }
    
    deinit{
        cancellable?.cancel()
        cancellableRequest?.cancel()
    }
    
    
    
    func login(){

        cancellableRequest =  interactor.login(loginRequest: SignInRequest(email: email,
                                                                           password: password))
        
        .receive(on: DispatchQueue.main)
        .sink { completion in
            //codigo de quando da erro
            switch(completion){
            case .failure(let appError):
                self.uiState = SignInUiState.error(appError.message)
                break
            case .finished:
                break
            }
            
        } receiveValue: { succes in
            //codigo de quando der sucesso no login
            let auth = UserAuth(idToken: succes.accessToken,
                                refreshToken: succes.refreshToken,
                                expires: Date().timeIntervalSince1970 + Double(succes.expires),
                                tokenType: succes.tokenType)
            
            self.interactor.insertAuth(userAuth: auth)
            print( "AQUI TEVE SUCESSO NO LOGIN DADOS ABAIXO: \(succes)")
            self.uiState = .goToHomeScreen
        }
        
        
        //INSTRUCAO ANTIGA DE LOGIN NO APP
        
        //        self.uiState = .loading
        //        interactor.login(loginRequest: SignInRequest(email: email, password: password)){
        //            (successResponse, errorResponse) in
        //
        //            if let error = errorResponse {
        //                DispatchQueue.main.async{
        //                    self.uiState = .error(error.detail.message)
        //                }
        //            }
        //
        //            if let success = successResponse {
        //                DispatchQueue.main.async {
        //                    print(success)
        //                    self.uiState = .goToHomeScreen
        //
        //                }
        //            }
        //
        //        }
    }
    
}

extension SignInViewModel {
    
    func homeView() -> some View{
        return SignInViewRouter.makeHomeView(homeViewModel: homeViewModel)
    }
    
    func signUpView() -> some View{
        return SignInViewRouter.makeSignUpView(publisher: publisher)
    }
    
}
