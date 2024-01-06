//
//  HabitCardViewModel.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 21/12/23.
//

import Foundation
import SwiftUI
import Combine

struct HabitCardViewModel: Identifiable, Equatable {
    
    var id: Int = 0
    var icon: String = ""
    var date: String = ""
    var name: String = ""
    var label: String = ""
    var value: String = ""
    var state: Color = .green
    
    var habitPublisher: PassthroughSubject<Bool, Never>
    
    
    static func == (lhs: HabitCardViewModel, rhs: HabitCardViewModel) -> Bool{
        return lhs.id == rhs.id
    }
}


extension HabitCardViewModel {
    func habitDetailView() -> some View {
        return HabitCardViewRouter.makeHabitDetailView(id: id, name: name, label: label, habitPublisher: habitPublisher)
    }
}
