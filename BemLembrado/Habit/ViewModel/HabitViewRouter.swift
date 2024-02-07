//
//  HabitViewRouter.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 17/01/24.
//

import Foundation
import Combine
import SwiftUI

enum HabitViewRouter {
    static func makeHabitCreateView(habitPublisher: PassthroughSubject<Bool, Never>? ) -> some View {
        let viewModel = HabitCreateViewModel(interactor: HabitCreateInteractor())
        viewModel.habitPublishher = habitPublisher
        return HabitCreateView(viewModel: viewModel)
    }
}
