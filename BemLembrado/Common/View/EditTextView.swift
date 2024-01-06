//
//  EditTextView.swift
//  Habitos
//
//  Created by Vinicius Wessner on 30/10/23.
//

import SwiftUI

struct EditTextView: View {
    
    @Binding var text: String
    var placeholder: String = ""
    var error: String? = nil
    var failure: Bool? = nil
    var isSecure: Bool = false
    var keyboard: UIKeyboardType = .default
    
    var body: some View {
        VStack{
            if isSecure{
                SecureField(placeholder, text: $text)
                    .foregroundColor(Color("textColor"))
                    .keyboardType(keyboard)
                    .textFieldStyle(CustomTextFieldStyle())
            } else {
                VStack{
                    TextField(placeholder, text: $text)
                        .foregroundColor(Color("textColor"))
                        .keyboardType(keyboard)
                        .textFieldStyle(CustomTextFieldStyle())
            }
                
                if let error = error, failure == true, !text.isEmpty {
                    Text(error).foregroundColor(.red)
                }
            }
        }.padding(.bottom, 10)
    }
    
}




struct EditTextView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self){
            VStack{
                EditTextView(text: .constant(""), 
                             placeholder: "Email",
                             error: "Campo Inválido",
                             failure:"a@a.com".count < 3)
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .previewDevice("iphone 11")
            .preferredColorScheme($0)
        }
    }
}

