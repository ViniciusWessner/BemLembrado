//
//  ButtonStyle.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 20/12/23.
//

import Foundation
import SwiftUI

struct ButtonStyle: ViewModifier {

    func body(content: Content) -> some View {
        content
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .padding(.horizontal, 16)
        .font(.system(.title3).bold())
        .background(Color("cordologo"))
        .foregroundColor(.white)
        .cornerRadius(4.0)
    }
}
