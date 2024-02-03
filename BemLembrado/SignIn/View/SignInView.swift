//
//  SignInView.swift
//  Habitos
//
//  Created by Vinicius Wessner on 22/10/23.
//

import SwiftUI

struct SignInView: View {
    
    //buscando as referencias
    @ObservedObject var viewModel: SignInViewModel
    

    @State var action: Int? = 0
    @State var navigationHidden = true
    
    var body: some View {
        
        ZStack{
            if case SignInUiState.goToHomeScreen = viewModel.uiState{
                viewModel.homeView()
            }else{
                //conteudo da tela
                NavigationView{
                    
                    ScrollView(showsIndicators: false){
                    
                        VStack (alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20){
                            
                            Spacer(minLength: 36)
                            
                            VStack (alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 8){
                                Image("logo")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.horizontal, 48)
                                
                                Text("Login")
                                    .foregroundColor(Color("cordologo"))
                                    .font(Font.system(.title).bold())
                                    .padding(.bottom, 8)
                                
                                emailField
                                
                                passwordField
                                
                                enterButton
                                
                                registerLink
                                    
                                Text("Desenvolvido por Wessner")
                                    .foregroundColor(Color.gray)
                                    .font(Font.system(size: 16).bold())
                                    .padding(.top, 16)
                            }
                            
                        }
                        
                        if case SignInUiState.error(let value) = viewModel.uiState{
                            Text("")
                                .alert(isPresented: .constant(true)){
                                    Alert(title: Text("Habbit"), message: Text(value), dismissButton: .default(Text("Ok")) {
                                        //evento do botao de acao aqui
                                        
                                    })
                                }
                        }
                            
                            
                    }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                    .padding(.horizontal, 32)
                    .navigationBarTitle("Login", displayMode: .inline)
                    .navigationBarHidden(navigationHidden)
                }
                .onAppear{
                    self.navigationHidden = true
                }
                
                .onDisappear {
                    self.navigationHidden = false
                }
            }
        }
        

    
    }
    
}

extension SignInView{
    var emailField: some View{
  //      SecureField("", text: $senha)
//        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
        EditTextView(text: $viewModel.email,
                     placeholder: "Email",
                     error: "Email inválido",
                     failure: !viewModel.email.isEmail(),
                     keyboard: .emailAddress)
            
    }
}

extension SignInView {
    var passwordField: some View {
        EditTextView(text: $viewModel.password,
                     placeholder: "Senha",
                     error: "Senha deve ter ao menos 8 caracteres", 
                     failure: viewModel.password.count < 8,
                     isSecure: true,
                     keyboard: .emailAddress)
    }
}

extension SignInView {
    var enterButton: some View{
        
            LoadingButtonView(action: {
                viewModel.login()
            },
              text: "Entrar",
              showProgress: self.viewModel.uiState == SignInUiState.loading,
                              disabled: !viewModel.email.isEmail() || viewModel.password.count < 8)
        }
    }



extension SignInView{
    var registerLink: some View{
        VStack{
            Text("Ainda nao possui cadastro?")
                .foregroundColor(.gray)
                .padding(.top, 48)
            
            ZStack{
                NavigationLink(
                    destination: viewModel.signUpView(),
                    tag: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/,
                    selection: $action ,
                    label: {EmptyView() })
                
                Button("Realizar meu cadastro"){
                    self.action = 1
                }
            }
        }
    }
}



struct SignInView_Previews: PreviewProvider{
    static var previews: some View{
        ForEach(ColorScheme.allCases, id: \.self){
            let viewModel = SignInViewModel(interactor: SignInInteractor())
            SignInView(viewModel: viewModel)
                .previewDevice("iphone 11")
                .preferredColorScheme($0)
        }
    }
}
