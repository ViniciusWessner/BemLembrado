//
//  SignUpView.swift
//  Habitos
//
//  Created by Vinicius Wessner on 25/10/23.
//

import SwiftUI

struct SignUpView: View {
    
    //nome completo
    //senha
    //email
    //cpf
    //telefone
    //data de nascimento
    //genero
    
    
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
                     error: "Deve conter mais de 3 letras",
                     failure: viewModel.fullName.count < 3,
                     keyboard: .alphabet)
    }
}

extension SignUpView {
    var emailField: some View {
        EditTextView(text: $viewModel.email,
                     placeholder: "Email",
                     error: "Email inválido",
                     failure: !viewModel.email.isEmail(),
                     keyboard: .emailAddress)
    }
}

extension SignUpView{
    var passwordFiel: some View{
        EditTextView(text: $viewModel.password,
                     placeholder: "Senha",
                     error: "Senha deve ter ao menos 8 caracteres",
                     failure: viewModel.password.count < 8,
                     isSecure: true,
                     keyboard: .emailAddress)
    }
}



extension SignUpView {
    var documentField: some View {
        EditTextView(text: $viewModel.document,
                     placeholder: "CPF",
                     error: "CPF incorreto",
                     failure: viewModel.document.count != 11,
                     keyboard: .numberPad)
        //TODO:  CPF - criar mascara pro cpf pontos etc
        //TODO: CPF - Marcar ele como nao editavel depois pois ele é unico
    }
}
    
    
    
extension SignUpView {
    var phoneField: some View {
        EditTextView(text: $viewModel.phone,
                     placeholder: "Numero de celular",
                     error: "Telefone inválido insira o DDD + 8 ou 9 digitos",
                     failure: viewModel.phone.count < 10 || viewModel.phone.count >= 12 ,
                     keyboard: .phonePad)
  }
}

extension SignUpView {
    var birthdayField: some View {
        EditTextView(text: $viewModel.birthday,
                     placeholder: "Data de Nascimento",
                     error: "Insira no padrao DD/MM/AAAA",
                     failure: viewModel.birthday.count != 10,
                     keyboard: .emailAddress)
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
    var saveButton: some View{
        
        LoadingButtonView(action: {
            viewModel.signUp()
        }, text: "Realizar Cadastro",
           showProgress: self.viewModel.uiState == SignUpUiState.loading,
           disabled: 
                !viewModel.email.isEmail() ||
              viewModel.password.count < 8 || viewModel.fullName.count < 3 ||
              viewModel.document.count != 11 || viewModel.phone.count >= 12 ||
              viewModel.birthday.count != 10)
        
        }
    }







struct SignUpView_Previews: PreviewProvider{
    static var previews: some View{
        SignUpView(viewModel: SignUpViewModel(interactor: SignUpInteractor()))
    }
}

