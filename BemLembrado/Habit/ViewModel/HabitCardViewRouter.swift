//
//  HabitCardViewRouter.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 27/12/23.
//

import Foundation
import SwiftUI
import Combine

enum HabitCardViewRouter{
    
    static func makeHabitDetailView(id: Int, name: String, label: String, habitPublisher: PassthroughSubject<Bool, Never>? ) -> some View {
        let viewModel = HabitDetailViewModel(id: id, name: name, label: label, interactor: HabitDetailInteractor())
        viewModel.habitPublishher = habitPublisher
        return HabitDetailView(viewModel: viewModel)
    }
    
    static func makeChartView(id: Int) -> some View {
        return ChartView()
    }
}
