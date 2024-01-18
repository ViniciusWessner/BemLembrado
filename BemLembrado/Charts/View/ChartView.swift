//
//  ChartView.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 08/01/24.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    @ObservedObject var viewModel: ChartViewModel
    
    var body: some View {
 
        ZStack {
            if case ChartUiState.loading = viewModel.uiState {
                ProgressView()
            } else {
                VStack{
                    if case ChartUiState.emptyChart = viewModel.uiState {
                        Image(systemName: "exclamationmark.bubble.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24, alignment: .center)
                        
                        Text("Nenhum hábito encontrado")
                    } else if case ChartUiState.error(let msg) = viewModel.uiState {
                        Text("")
                          .alert(isPresented: .constant(true)) {
                            Alert(
                              title: Text("Ops! \(msg)"),
                              message: Text("Deseja recarregar a pagina?"),
                              primaryButton: .default(Text("Sim")) {
                                // aqui executa a retentativa
                                  viewModel.onAppear()
                              },
                              secondaryButton: .cancel()
                            )
                          }
                        //caso der sucesso, mostrar o box
                    }else {
                        BoxChartView(entries: $viewModel.entries, dates: $viewModel.dates)
                            .frame(maxWidth: .infinity, maxHeight: 350)
                    }

                }

            }
        }
        .onAppear(perform: viewModel.onAppear)
    }
}

#Preview {
    ChartView(viewModel: ChartViewModel(habitId: 1, interactor: ChartInteractor()))
}
