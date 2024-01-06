//
//  CustomTextFieldStyle.swift
//  Habitos
//
//  Created by Vinicius Wessner on 04/11/23.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle{
    public func _body(configuration: TextField<Self._Label>)-> some View{
        configuration
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .overlay(
                RoundedRectangle(cornerRadius: 8.0)
                    .stroke(Color("cordologo"), lineWidth: 0.8)
                )
    }
    
    
}
