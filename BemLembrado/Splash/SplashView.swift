//
//  SplashView.swift
//  Habitos
//
//  Created by Vinicius Wessner on 17/10/23.
//

import SwiftUI

struct SplashView: View {
    
    //podemos observar o viewmodelsplash
    @ObservedObject var viewModel: SplashViewModel
    
    //Chamada de respostas das telas
    var body: some View {
        Group{
            switch viewModel.uiState {
            case .loading:
                loadingview()
            case .gotoSignInScreen:
                //implementar aqui a navegacao para a proxima tela
                viewModel.signInView()
            case .goToHomeScreen:
                //implementear navegacao para a proxima tela
                viewModel.homeView()
            case .erro(let msg):
                loadingview(error: msg)
            }
        }.onAppear(perform: {
            viewModel.onAppear()
        })
    }
}

//1 - compartilhamento de objetos (usado quando precisamos usar este logotipo dessa forma em outros locais do nosso projeto
struct LoadingView:View {
    var body: some View {
        ZStack{
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(20)
                .ignoresSafeArea()
        }
    }
}

// 2- variaveis em uma extensao, podemos usar quando nao precisamos passar nenhum parametro de retorno, muito utilizado apenas para estilizar exemplo um css da vida
extension SplashView {
    var loading: some View{
        ZStack{
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(20)
                .ignoresSafeArea()
        }
    }
}

// a extencion com funcao ela basicamente é uma funcao que ao inves de estar colada no body ela está sendo extendida apenas para organizar o codigo
extension SplashView{
    func loadingview(error: String? = nil) -> some View{
        ZStack{
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(20)
                .ignoresSafeArea()
            
            if let error = error{
                Text("")
                    .alert(isPresented: .constant(true)){
                        Alert(title: Text("Habbit"), message: Text(error), dismissButton: .default(Text("Ok")) {
                            //evento do botao de acao aqui
                            
                        })
                    }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider{
    static var previews: some View{
        ForEach(ColorScheme.allCases, id: \.self){
            let viewModel = SplashViewModel(interactor: SplashInteractor())
             SplashView(viewModel: viewModel)
                .previewDevice("iphone 11")
                .preferredColorScheme($0)
            //SplashView(state: .loading)
        }

    }
}

