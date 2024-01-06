//
//  SignUpViewRouter.swift
//  Habitos
//
//  Created by Vinicius Wessner on 25/10/23.
//

import SwiftUI
import Combine


enum SignUpViewRouter{
    
    static func makeHomeView() -> some View{
        let viewModel = HomeViewModel()
        return Homeview(viewModel: viewModel)
    }
}
