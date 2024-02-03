//
//  HabitCreateViewModel.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 17/01/24.
//

import Foundation
import SwiftUI
import Combine

class HabitCreateViewModel: ObservableObject {
    
    @Published var uiState: HabitDetailUiState = .none
    @Published var name = ""
    @Published var label = ""
    
    @Published var image: Image? = Image(systemName: "camera")
    
    @Published var imageData: Data? = nil
    
    private var cancellable: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    var habitPublishher: PassthroughSubject<Bool, Never>?
    
    let interactor: HabitCreateInteractor
    
    init(interactor: HabitCreateInteractor) {

        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }
    
    func save() {
        self.uiState = .loading
        
        cancellable = interactor.save(habitCreateRequest: HabitCreateRequest(imageData: imageData,
                                                                             name: name,
                                                                             label: label))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {  completion in
                switch(completion){
                    case .failure(let appError):
                        self.uiState = .error(appError.message)
                        break
                    case .finished:
                        break
                }
            }, receiveValue: {
                self.uiState = .success
                self.habitPublishher?.send(true)
            })
    }
}
