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
    
    private var cancellable: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    var habitPublishher: PassthroughSubject<Bool, Never>?
    
    let interactor: HabitDetailInteractor
    
    init(interactor: HabitDetailInteractor) {

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
    }
}
