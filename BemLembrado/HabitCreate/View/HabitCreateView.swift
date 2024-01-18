//
//  HabitCreateView.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 17/01/24.
//

import SwiftUI


          
struct HabitCreateView: View {
    
    @ObservedObject var viewModel: HabitCreateViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var shouldPresentCamera = false
    
    init(viewModel: HabitCreateViewModel) {
        self.viewModel = viewModel
    }
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: 12){
                    Button(action: {
                      //action do button aqui
                        self.shouldPresentCamera = true
                    }, label: {
                        VStack {
                            Image(systemName: "camera")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.cordologo)
                            
                            Text("Tirar Foto")
                                .foregroundColor(.cordologo)
                        }
                        .padding(.top, 50)
                })
                    .padding(.bottom, 12)
            }
                
                VStack{
                    TextField("Nome do hábito", text: $viewModel.name)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(PlainTextFieldStyle())
                        .keyboardType(.numberPad)
                    
                    Divider()
                        .frame(height: 1)
                        .background(Color.gray)
                }.padding(.horizontal, 32)
            
            VStack{
                TextField("Unidade de medida", text: $viewModel.label)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(PlainTextFieldStyle())
                    .keyboardType(.alphabet)
                
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
            }.padding(.horizontal, 32)
                
                
                LoadingButtonView(action: {
                    //acao aqui
                    viewModel.save()
                }, text: "Salvar",
                showProgress: self.viewModel.uiState == .loading,
                disabled: self.viewModel.name.isEmpty || self.viewModel.label.isEmpty)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                
                Button("Cancelar"){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        withAnimation(.easeOut(duration: 2)) {
                            //dimiss/ pop exit
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }

                }
                .modifier(ButtonStyle())
                .padding(.horizontal, 16)
                
                Spacer()
            }
            .padding(.horizontal, 8)
            .padding(.top, 32)

        }
    }




struct HabitCreateView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self){
            HabitCreateView(viewModel: HabitCreateViewModel(interactor: HabitDetailInteractor()))
                .previewDevice("iphone 11")
                .preferredColorScheme($0)
        }
    }
}

        
