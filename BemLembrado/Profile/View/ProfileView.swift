//
//  ProfileView.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 03/01/24.
//

import SwiftUI

struct ProfileView: View {

    @ObservedObject var viewModel: ProfileViewModel
    
    var disableDone: Bool {
        viewModel.fullNameValidation.failure ||
        viewModel.birthdayValidation.failure ||
        viewModel.phoneValidation.failure
    }

    
    var body: some View {
      
        ZStack {
            //loading aprece a progress
            if case ProfileUiState.loading = viewModel.uiState {
                ProgressView()
            } else { //sucesso aparece a navigation
                NavigationView {
                    
                    VStack{
                        Form {
                            Section(header: Text("Dados cadastrais")) {
                                HStack{
                                    Text("Nome")
                                    Spacer()
                                    TextField("Digite o nome", text: $viewModel.fullNameValidation.value)
                                        .keyboardType(.alphabet)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                if viewModel.fullNameValidation.failure {
                                    Text("Nome deve ter mais de 3 caracteres")
                                        .foregroundColor(.red)
                                }
                                
                                HStack{
                                    Text("E-mail")
                                    Spacer()
                                    TextField("", text: $viewModel.email)
                                        .disabled(true)
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                HStack{
                                    Text("CPF")
                                    Spacer()
                                    TextField("", text: $viewModel.document)
                                        .disabled(true)
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                HStack{
                                    Text("Celular")
                                    Spacer()
                                    TextField("Digite o seu celular", text: $viewModel.phoneValidation.value)
                                        .keyboardType(.numberPad)
                                        .multilineTextAlignment(.trailing)
                                    
                                    if viewModel.phoneValidation.failure {
                                        Text("Telefone inválido")
                                            .foregroundColor(.red)
                                    }
                                    
                                }
                                
                                HStack{
                                    Text("Data de Nascimento")
                                    Spacer()
                                    TextField("Digite a data de nascimento", text: $viewModel.birthdayValidation.value)
                                        .multilineTextAlignment(.trailing)
                                    
                                    if viewModel.birthdayValidation.failure {
                                        Text("Insira no padrao DD/MM/AAAA")
                                            .foregroundColor(.red)
                                    }
                                    
                                }
                                
                                NavigationLink(
                                    destination: GenderSelectorView(selectedGender: $viewModel.gender,
                                                                    title: "Escolha o genero",
                                                                    genders: Gender.allCases),
                                    
                                    label: {
                                        Text("Genero")
                                        Spacer()
                                        Text(viewModel.gender?.rawValue ?? "")
                                            .multilineTextAlignment(.trailing)
                                    })
                                
                            }
                        }
                    }
                    
                    .navigationBarTitle(Text("Editar Perfil"), displayMode: .automatic)
                    .navigationBarItems(trailing: Button(action: {
                        //todo: evento de gravacao dos dados
                        viewModel.updateUser()
                    }, label: {
                        if case ProfileUiState.updateLoading = viewModel.uiState {
                            ProgressView()
                        } else {
                            Image(systemName: "checkmark")
                                .foregroundColor(.cordologo)
                        }
                    })
                        .alert(isPresented: .constant(viewModel.uiState == .updateSuccess)) {
                            Alert(title: Text("Habit"),
                                  message: Text("Dados atualizados com sucesso"),
                                  dismissButton: .default(Text("Ok")) {
                                    viewModel.uiState = .none
                            })
                        }
                        .opacity(disableDone ? 0 : 1)
                    )
                    
                }
            } //erro aparece o alerta
            if case ProfileUiState.fetchError(let value) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)){
                        Alert(title: Text("Habbit"), message: Text(value), dismissButton: .default(Text("Ok")) {
                            //evento do botao de acao aqui
                            
                        })
                    }
            }
            
            if case ProfileUiState.updateError(let value) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)){
                        Alert(title: Text("Habbit"), message: Text(value), dismissButton: .default(Text("Ok")) {
                            //evento do botao de acao aqui
                            viewModel.uiState = .none
                            
                        })
                    }
            }
        }.onAppear(perform: viewModel.fetchUser)
    }
}

#Preview {
    ProfileView(viewModel: ProfileViewModel(interactor: ProfileInteractor()))
}
