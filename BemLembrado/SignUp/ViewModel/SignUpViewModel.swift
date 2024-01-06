//
//  SignUpViewModel.swift
//  Habitos
//
//  Created by Vinicius Wessner on 25/10/23.
//

import SwiftUI
import Combine



class SignUpViewModel: ObservableObject{
    
    
    @Published var fullName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var document = ""
    @Published var phone = ""
    @Published var birthday = ""
    @Published var gender = Gender.male
    
    var publisher: PassthroughSubject<Bool, Never>!
    
    private var cancellableSignIn: AnyCancellable?
    private var cancellableSignUp: AnyCancellable?
    
    
    @Published var uiState: SignUpUiState = .none
    
    private let interactor: SignUpInteractor
    
    init(interactor: SignUpInteractor){
        self.interactor = interactor
    }
    
    deinit{
        cancellableSignIn?.cancel()
        cancellableSignUp?.cancel()
    }
    
    func signUp(){
        self.uiState = .loading
        
        //pegando a string -> e transformando ela em dd/MM/yyyy
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        
        //pegando dd/MM/yyyy e formatando para o tipo DATE
        let dateFormatted = formatter.date(from: birthday)
        
        //validamos se a data que foi escrita estava nos padroes dd/MM/yyyy
        guard let dateFormatted = dateFormatted else{
            self.uiState = .error("Data \(birthday) inválida")
            return
        }
        
        // inveremos a data para o padrao que a API solicita
        formatter.dateFormat = "yyyy-MM-dd"
        let birthday = formatter.string(from: dateFormatted)
        
        let SignUpRequest = SignUpRequest(fullName: fullName,
                                          email: email,
                                          password: password,
                                          document: document,
                                          phone: phone,
                                          birthday: birthday,
                                          gender: gender.index)
        
        cancellableSignUp = interactor.postUser(signUpRequest: SignUpRequest)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                //error // finished
                switch(completion){
                case .failure(let appError):
                    self.uiState = .error(appError.message)
                    break
                case .finished:
                    break
                    
                }
            } receiveValue: { created in
                if (created) {
                    // se tiver criado, fazer login
                    self.cancellableSignIn = self.interactor.login(signInRequest: SignInRequest(email: self.email, password: self.password))
                        .receive(on: DispatchQueue.main)
                        .sink { completion in
                            //failure // finished
                            switch(completion){
                            case .failure(let appError):
                                self.uiState = .error(appError.message)
                                break
                            case .finished:
                                break
                            }
                        } receiveValue: { succes in
                            print(created)
                            self.publisher.send(created)
                            
                            let auth = UserAuth(idToken: succes.accessToken,
                                                refreshToken: succes.refreshToken,
                                                expires: Date().timeIntervalSince1970 + Double(succes.expires),
                                                tokenType: succes.tokenType)
                            
                            self.interactor.insertAuth(userAuth: auth)
                            self.uiState = .success
                        }
                    
                }
            }
        
        
        
    }
}



extension SignUpViewModel {
    
    func signUpView() -> some View{
        return SignUpViewRouter.makeHomeView()
    }
    
}
