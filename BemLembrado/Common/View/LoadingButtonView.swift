//
//  LoadingButtonView.swift
//  Habitos
//
//  Created by Vinicius Wessner on 05/11/23.
//

import SwiftUI

struct LoadingButtonView: View {
    
    var action: () -> Void
    var text: String
    var showProgress: Bool =  false
    var disabled: Bool = false
    

    
    var body: some View {
        
        ZStack{
            Button(action: {
                action()
            }, label: {
                Text(showProgress ? " " : text)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 16)
                    .font(.system(.title3).bold())
                    .background(disabled ? Color("cordologoligth") : Color("cordologo"))
                    .foregroundColor(.white)
                    .cornerRadius(4.0)
            }).disabled(disabled || showProgress)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .opacity(showProgress ? 1 : 0)
        }
    }
}

struct LoadingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self){
            VStack{
                LoadingButtonView(action: {
                    print("Ola")
                },text: "Entrar",
                showProgress: false,
                disabled: false)
                
                
            }.padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .previewDevice("iphone 11")
            .preferredColorScheme($0)
        }
    }
}
