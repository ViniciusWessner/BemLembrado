//
//  ProfileEditTextView.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 07/02/24.
//

import SwiftUI

struct ProfileEditTextView: View {
  
  @Binding var text: String
  
  var placeholder: String = ""
  var mask: String? = nil
  var keyboard: UIKeyboardType = .default
  var autocapitalization: UITextAutocapitalizationType = .none
  
  var body: some View {
    VStack {
        TextField(placeholder, text: $text)
            .foregroundColor(Color("textColor"))
          .keyboardType(keyboard)
          .autocapitalization(autocapitalization)
          .multilineTextAlignment(.trailing)
          .onChange(of: text) { value in
            if let mask = mask {
              Mask.mask(mask: mask, value: value, text: &text)
            }
          }

    }
    .padding(.bottom, 10)
    
  }
}

struct ProfileEditTextView_Previews: PreviewProvider {
  static var previews: some View {
    ForEach(ColorScheme.allCases, id: \.self) {
      VStack {
        ProfileEditTextView(text: .constant("Texto"),
                     placeholder: "E-mail")
          .padding()
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .previewDevice("iPhone 11")
      .preferredColorScheme($0)
    }
    
  }
}


