//
//  HabitViewModel.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 18/12/23.
//

import Foundation
import Combine
import SwiftUI

class HabitViewModel: ObservableObject {
    
    @Published var uiState: HabitUiState = .loading
    
    @Published var title = ""
    @Published var headline = ""
    @Published var desc = ""
    
    @Published var opened = false
    
    private var cancellableRequest: AnyCancellable?
    private var cancellableNotify: AnyCancellable?
    
    private let interactor: HabitInteractor
    let isCharts: Bool
    
    private let habitPublisher = PassthroughSubject<Bool,Never>()
    
    init(isCharts: Bool,interactor: HabitInteractor) {
        self.isCharts = isCharts
        self.interactor = interactor
        
        cancellableNotify = habitPublisher.sink(receiveValue: { saved in
            print("saved: \(saved)")
            self.onAppear()
        })
    }
    
    deinit {
        cancellableRequest?.cancel()
        cancellableNotify?.cancel()
    }
    
    func onAppear() {
        self.opened = true
        self.uiState = .loading
        
        cancellableRequest = interactor.fetchHabits()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch(completion) {
                case .failure(let appError):
                    self.uiState = .error(appError.message)
                    break
                case .finished:
                    break
                }
            }, receiveValue: { response in
                if response.isEmpty {
                    self.uiState = .emptyList
                    
                    self.title = ""
                    self.headline = "Fique ligado!"
                    self.desc = "Você ainda não possui hábitos!"
                } else {
                    self.uiState = .fullList(
                        response.map {
                            
                            let lastDate = $0.lastDate?.toDate(sourcePattern: "yyyy-MM-dd'T'HH:mm:ss",
                                                               destPattern: "dd/MM/yyyy HH:mm") ?? ""
                            
                            var state = Color.green
                            self.title = "Muito bom!"
                            self.headline = "Seus hábitos estão em dia"
                            self.desc = ""
                            
                            let dateToCompare = $0.lastDate?.toDate(sourcePattern: "yyyy-MM-dd'T'HH:mm:ss") ?? Date()
                            if dateToCompare < Date() {
                                state = .red
                                self.title = "Atenção"
                                self.headline = "Fique ligado!"
                                self.desc = "Você está atrasado nos hábitos"
                            }
                            
                            
                            return HabitCardViewModel(id: $0.id,
                                                      icon: $0.iconUrl ?? "",
                                                      date: lastDate,
                                                      name: $0.name,
                                                      label: $0.label,
                                                      value: "\($0.value ?? 0)",
                                                      state: state,
                                                      habitPublisher: self.habitPublisher)
                            
                        }
                    )
                    
                }
            })
        
    }
    
    
}
