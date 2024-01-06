//
//  ImageView.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 03/01/24.
//

import SwiftUI
import Combine

struct ImageView: View {
    
    @State var image: UIImage = UIImage()
    @ObservedObject var imageLoader: ImageLoader
 
    //2 - VAI SER CRIADO O CARREGADOR DE IMAGENS PASSANDO A URL PRA ELE (VAI FICAR ESCUTANDO O INIT)
    init(url: String) {
        imageLoader = ImageLoader(url: url)
    }
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .onReceive(imageLoader.didChange, perform: { data in
                self.image = UIImage(data: data) ?? UIImage()
            })
    }
}

class ImageLoader: ObservableObject {
    
    var didChange = PassthroughSubject<Data, Never> ()
//4 - SEMPRE QUE FOR ATRIBUIDO ALGO NA VARIAVEL DATA O DIDCHANGE VAI DISPARAR PRA TODOS QUE OBSERVAM ELE
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }
// 3 - VAI INICIAR O PROCESSO DE CARREGAMENTO DOS BYTES DE UMA IMAGEM
    init(url:String) {
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            //VALIDA SE OS BYTES DERAM SUCESSO E GUARDA ELES NA VARIAVEL DATA
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}

// 1 -  TODA A VEZ QUE EU CRIAR UMA IMAGEMVIEW E PASSAR UMA URL

#Preview {
    ImageView(url: "https://cdn.tiagoaguiar.co/habit_plus/850/1704288696.335382-1704288696.334377.jpeg")
}
