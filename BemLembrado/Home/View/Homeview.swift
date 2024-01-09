//
//  Homeview.swift
//  Habitos
//
//  Created by Vinicius Wessner on 25/10/23.
//

import SwiftUI

struct Homeview: View {

    @ObservedObject var viewModel : HomeViewModel
    @State var selecion = 0
    
    var body: some View {
        
        TabView(selection: $selecion){
            viewModel.habitView()
            .tabItem {
                    Image(systemName: "text.badge.plus")
                    Text("Hábitos")
                }.tag(0) 
            
//            Text("Conteudo de graficos\(selecion)")
                viewModel.habitForChartView()
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("Graficos")
                }.tag(1)
            
//            Text("Conteudo de perfil\(selecion)")
            viewModel.profileView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Perfil")
                }.tag(2)
        }
        .background(Color.white)
        .accentColor(Color.cordologo)
    }
}

struct HomeView_Previews: PreviewProvider{
    static var previews: some View{
        let viewModel = HomeViewModel()
         Homeview(viewModel: viewModel)
    }
}
