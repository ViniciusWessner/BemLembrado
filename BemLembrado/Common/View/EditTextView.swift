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
  var mask: String? = nil
  var keyboard: UIKeyboardType = .default
  var error: String? = nil
  var failure: Bool? = nil
  var isSecure: Bool = false
  var autocapitalization: UITextAutocapitalizationType = .none
  
  var body: some View {
    VStack {
      if isSecure {
        SecureField(placeholder, text: $text)
          .foregroundColor(Color("textColor"))
          .keyboardType(keyboard)
          .textFieldStyle(CustomTextFieldStyle())
      } else {
        TextField(placeholder, text: $text)
          .foregroundColor(Color("textColor"))
          .keyboardType(keyboard)
          .autocapitalization(autocapitalization)
          .textFieldStyle(CustomTextFieldStyle())
          .onChange(of: text) { value in
            if let mask = mask {
              Mask.mask(mask: mask, value: value, text: &text)
            }
          }
      }
      
      if let error = error, failure == true, !text.isEmpty {
        Text(error).foregroundColor(.red)
      }
    }
    .padding(.bottom, 10)
    
  }
}

struct EditTextView_Previews: PreviewProvider {
  static var previews: some View {
    ForEach(ColorScheme.allCases, id: \.self) {
      VStack {
        EditTextView(text: .constant("Texto"),
                     placeholder: "E-mail",
                     error: "Campo inválido",
                     failure: "a@a.com".count < 3)
          .padding()
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .previewDevice("iPhone 11")
      .preferredColorScheme($0)
    }
    
  }
}

