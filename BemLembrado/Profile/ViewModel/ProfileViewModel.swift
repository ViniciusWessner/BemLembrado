//
//  ProfileViewModel.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 03/01/24.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    
    @Published var uiState: ProfileUiState = .none
    
    @Published var fullNameValidation = FullNameValidation()
    @Published var phoneValidation = PhoneValidation()
    @Published var birthdayValidation = BirthdayValidation()
    
    var userId: Int?
    @Published var email = ""
    @Published var document = ""
    @Published var gender: Gender?
    
    private var cancellable: AnyCancellable?
    
    private let interactor: ProfileInteractor
    
    init(interactor: ProfileInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func fetchUser() {
        self.uiState = .loading
        
        cancellable = interactor.fetchUser()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch(completion){
                case .failure(let appError):
                    self.uiState = .fetchError(appError.message)
                    break
                case .finished:
                    break
                }
            }, receiveValue: { response in
                self.userId = response.id
                self.email = response.email
                self.document = response.document
                self.gender = Gender.allCases[response.gender]
                self.fullNameValidation.value = response.fullName
                self.phoneValidation.value = response.phone
                
                //pegando a string -> e transformando ela em dd/MM/yyyy
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.dateFormat = "yyyy-MM-dd"
                
                //pegando dd/MM/yyyy e formatando para o tipo DATE
                let dateFormatted = formatter.date(from: response.birthday)
                
                //validamos se a data que foi escrita estava nos padroes dd/MM/yyyy
                guard let dateFormatted = dateFormatted else{
                    self.uiState = .fetchError("Data \(response.birthday) inválida")
                    return
                }
                
                // inveremos a data para o padrao que a API solicita
                formatter.dateFormat = "dd/MM/yyyy"
                let birthday = formatter.string(from: dateFormatted)
                
                self.birthdayValidation.value = birthday
                self.uiState = .fetchSuccess
            })

    }
}

class FullNameValidation: ObservableObject {
    @Published var failure = false
    var value: String = "Vinicius Wessner" {
        didSet {
            failure = value.count < 3
        }
    }
}

class PhoneValidation: ObservableObject {
    @Published var failure = false
    var value: String = "" {
        didSet {
            failure = value.count < 10 || value.count >= 12
        }
    }
}

class BirthdayValidation: ObservableObject {
    @Published var failure = false
    var value: String = "" {
        didSet {
            failure = value.count != 10
        }
    }
}
