//
//  HabitosApp.swift
//  Habitos
//
//  Created by Vinicius Wessner on 17/10/23.
//

import SwiftUI

@main
struct HabitosApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView(viewModel: SplashViewModel(interactor: SplashInteractor()))
        }
    }
}
