//
//  SplashViewModel.swift
//  Habitos
//
//  Created by Vinicius Wessner on 18/10/23.
//

import SwiftUI
import Combine

//pode ser observada
class SplashViewModel : ObservableObject{
    
    @Published var uiState: SplashUIState = .loading
    
    private var cancellableAuth: AnyCancellable?
    private var cancellableRefresh: AnyCancellable?
    
    private let interactor: SplashInteractor
    
    
    init(interactor: SplashInteractor){
        self.interactor = interactor

    }
    
    deinit{
        cancellableRefresh?.cancel()
        cancellableAuth?.cancel()
    }
    
    
    
    func onAppear(){
       cancellableAuth = interactor.fetchAuth()
            .delay(for: .seconds(2), scheduler: RunLoop.main)
            .receive(on: DispatchQueue.main)
            .sink { userAuth in
                // se userAuth for == nulo -> Login
                if userAuth == nil {
                    self.uiState = .gotoSignInScreen
                }
                //se nao se userAuth for != null && expirou
                else if (Date().timeIntervalSince1970 > Double(userAuth!.expires)) {
                    print("TOKEN DE ACESSO EXPIROU")
                    //vai tentar gerar um novo token chamando o refresh token na API
                    self.cancellableRefresh = self.interactor.refreshToken(refreshRequest: RefreshRequest(token: userAuth!.refreshToken))
                        .receive(on: DispatchQueue.main)
                    //caso algo tiver invalido MANDA FAZER O LOGIN NOVAMENTE
                        .sink(receiveCompletion: { completion in
                            switch(completion){
                                //se o token ficar invalido -> vai pro login
                            case .failure(_):
                                self.uiState = .gotoSignInScreen
                                break
                            default:
                                break
                            }
                        }, receiveValue: { succes in
                            //caso der sucesso no login, salva todas as credenciais novamente e manda pra tela principal
                        let auth = UserAuth(idToken: succes.accessToken,
                                            refreshToken: succes.refreshToken,
                                            expires: Date().timeIntervalSince1970 + Double(succes.expires),
                                            tokenType: succes.tokenType)
                            
                            self.interactor.insertAuth(userAuth: auth)
                            
                            self.uiState = .goToHomeScreen
                            
                        })
                }
                //caso contrario -> manda pra tela principal
                else{
                    self.uiState = .goToHomeScreen
                }

            }
    }
}
    
    
extension SplashViewModel {
    //funcao que nos devolve uma view
    func signInView() -> some View{
        return SplashViewRouter.makeSignInView()
    }   
    
    func homeView() -> some View{
        return SplashViewRouter.makeHomeView()
    }
  }

