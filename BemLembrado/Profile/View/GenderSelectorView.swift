//
//  GenderSelectorView.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 03/01/24.
//

import SwiftUI

struct GenderSelectorView: View {
    
    @Binding var selectedGender: Gender?
    
    let title: String
    let genders: [Gender]
    
    var body: some View {
        Form{
            Section(header: Text(title)) {
                List(genders, id:\.id) { item in
                    
                    HStack{
                        Text(item.rawValue)
                        Spacer()
                        Image(systemName: "checkmark")
                            .foregroundColor(selectedGender == item ? .cordologo : .white)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if !(selectedGender == item) {
                            selectedGender = item
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    GenderSelectorView(selectedGender: .constant(.male), title: "teste", genders: Gender.allCases)
}
