//
//  SignUpView.swift
//  Habitos
//
//  Created by Vinicius Wessner on 25/10/23.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var viewModel: SignUpViewModel
    
    var body: some View {
        
        ZStack{
            
            ScrollView(showsIndicators: false){
                VStack(alignment: .center){
                    VStack(alignment: .leading, spacing: 8){
                        
                        Text("Realizar cadastro")
                            .foregroundColor(Color("cordologo"))
                            .font(Font.system(.title).bold())
                            .padding(.bottom, 8)
                        
                        fullNameField
                        emailField
                        passwordFiel
                        documentField
                        phoneField
                        birthdayField
                        genderField
                        
                        
                        saveButton
                    }
                    Spacer()
                }.padding(.horizontal, 8)
            }.padding()
            
            if case SignUpUiState.error(let value) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)){
                        Alert(title: Text("Habbit"), message: Text(value), dismissButton: .default(Text("Ok")) {
                            //evento do botao de acao aqui
                            
                        })
                    }
            }
        }
    }
}


extension SignUpView {
    var fullNameField: some View {
        EditTextView(text: $viewModel.fullName,
                     placeholder: "Nome Completo",
                     keyboard: .default, 
                     error: "Deve conter mais de 3 letras",
                     failure: viewModel.fullName.count < 3,
                     autocapitalization: .words)
    }
}

extension SignUpView {
    var emailField: some View {
        EditTextView(text: $viewModel.email,
                     placeholder: "Email",
                     keyboard: .emailAddress, 
                     error: "Email inválido",
                     failure: !viewModel.email.isEmail())
    }
}

extension SignUpView{
    var passwordFiel: some View{
        EditTextView(text: $viewModel.password,
                     placeholder: "Senha",
                     keyboard: .emailAddress, 
                     error: "Senha deve ter ao menos 8 caracteres",
                     failure: viewModel.password.count < 8,
                     isSecure: true)
    }
}



extension SignUpView {
    var documentField: some View {
        EditTextView(text: $viewModel.document,
                     placeholder: "CPF",
                     mask: "###.###.###-##",
                     keyboard: .numberPad, 
                     error: "CPF incorreto",
                     failure: viewModel.document.count != 14)
        //TODO:  CPF - criar mascara pro cpf pontos etc
        //TODO: CPF - Marcar ele como nao editavel depois pois ele é unico
    }
}
    
    
    
extension SignUpView {
    var phoneField: some View {
        EditTextView(text: $viewModel.phone,
                     placeholder: "Numero de celular",
                     mask: "(##) ####-####",
                     keyboard: .phonePad, 
                     error: "Telefone inválido insira o DDD + 8 ou 9 digitos",
                     failure: viewModel.phone.count < 14 || viewModel.phone.count > 15 )
  }
}

extension SignUpView {
    var birthdayField: some View {
        EditTextView(text: $viewModel.birthday,
                     placeholder: "Data de Nascimento",
                     mask: "##/##/####",
                     keyboard: .numberPad,
                     error: "Insira no padrao DD/MM/AAAA",
                     failure: viewModel.birthday.count != 10)
        //TODO: data - Adicionar mascara depois
    }
}

extension SignUpView {
    var genderField: some View {
        Picker("Gender", selection: $viewModel.gender){
            ForEach(Gender.allCases, id: \.self){
                value in
                Text(value.rawValue)
                    .tag(value)
            }
        }.pickerStyle(SegmentedPickerStyle())
            .padding(.top, 16)
            .padding(.bottom, 32)
    }
}



extension SignUpView {
  var saveButton: some View {
    LoadingButtonView(action: {
      viewModel.signUp()
    },
    text: "Realize o seu Cadastro",
    showProgress: self.viewModel.uiState == SignUpUiState.loading,
    disabled: //botao vai ficar desabilitado se
      !viewModel.email.isEmail() ||
      viewModel.password.count < 8 ||
      viewModel.fullName.count < 3 ||
      viewModel.document.count != 14 ||
      viewModel.phone.count < 14 || viewModel.phone.count > 15 ||
      viewModel.birthday.count != 10)
  }
}







struct SignUpView_Previews: PreviewProvider{
    static var previews: some View{
        SignUpView(viewModel: SignUpViewModel(interactor: SignUpInteractor()))
    }
}

