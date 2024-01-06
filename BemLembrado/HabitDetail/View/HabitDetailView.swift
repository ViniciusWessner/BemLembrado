//
//  HabitDetailView.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 27/12/23.
//

import SwiftUI

struct HabitDetailView: View {
    
    @ObservedObject var viewModel:HabitDetailViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(viewModel: HabitDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: 12){
                Text(viewModel.name)
                    .foregroundColor(Color.cordologo)
                    .font(.title.bold())
                
                Text("Unidade: \(viewModel.label)\n")
                
                VStack{
                    TextField("Escreva aqui o valor conquistado", text: $viewModel.value)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(PlainTextFieldStyle())
                        .keyboardType(.numberPad)
                    
                    Divider()
                        .frame(height: 1)
                        .background(Color.gray)
                }.padding(.horizontal, 32)
                
                Text("Os registros devem ser feitos em ate 24h. \n  Hábitos se constroem todos os dias")
                
                LoadingButtonView(action: {
                    //acao aqui
                    viewModel.save()
                }, text: "Salvar",
                showProgress: self.viewModel.uiState == .loading,
                disabled: self.viewModel.value .isEmpty)
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
}


struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self){
            HabitDetailView(viewModel: HabitDetailViewModel(id: 1, name: "Caminhar 3km", label: "Km", interactor: HabitDetailInteractor()))
                .previewDevice("iphone 11")
                .preferredColorScheme($0)
        }
    }
}
