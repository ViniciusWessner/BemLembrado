//
//  HabitCardView.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 21/12/23.
//

import SwiftUI
import Combine

struct HabitCardView: View {
  
  @State private var action = false
  
    let isChart: Bool
  let viewModel: HabitCardViewModel
  
  var body: some View {
      ZStack(alignment: .trailing) {
      
      if isChart {
          
          NavigationLink(
            destination: viewModel.chartView(),
            isActive: self.$action,
            label: {
                EmptyView()
            }
          )
          
      } else {
          
          NavigationLink(
            destination: viewModel.habitDetailView(),
            isActive: self.$action,
            label: {
                EmptyView()
            }
          )
        }
      
      Button(action: {
        self.action = true
      }, label: {
        
        HStack {
            ImageView(url: viewModel.icon)
                .aspectRatio(contentMode: .fill)
                .frame(width: 32, height: 32)
                .clipped()
          Spacer()
          
          HStack(alignment: .top) {
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 4) {
              
              Text(viewModel.name)
                    .foregroundColor(Color.cordologo)
                            
              Text(viewModel.label)
                .foregroundColor(Color("textColor"))
                .bold()
              
              Text(viewModel.date)
                .foregroundColor(Color("textColor"))
                
              
            }.frame(maxWidth: 300, alignment: .leading)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 4) {
              
              Text("Registrado")
                .foregroundColor(Color.cordologo)
                .bold()
                .multilineTextAlignment(.leading)
              
              Text(viewModel.value)
                .foregroundColor(Color("textColor"))
                .bold()
                .multilineTextAlignment(.leading)
              
            }
            
            Spacer()
            
          }
          
          Spacer()
        }
        .padding()
        .cornerRadius(4.0)
        
      })
      
        if !isChart {
            Rectangle()
              .frame(width: 8)
              .foregroundColor(viewModel.state)
        }

      
    }.background(
      RoundedRectangle(cornerRadius: 4.0)
        .stroke(Color.cordologo, lineWidth: 1.4)
    )
    .padding(.horizontal, 4)
    .padding(.vertical, 8)
    
  }
}

struct HabitCardView_Previews: PreviewProvider {
  static var previews: some View {
    ForEach(ColorScheme.allCases, id: \.self) {
      NavigationView {
        
        List {
            HabitCardView(isChart: false, viewModel: HabitCardViewModel(id: 1,
                                                      icon: "https://via.placeholder.com/150",
                                                      date: "01/01/2021 00:00:00",
                                                      name: "Tocar guitarra",
                                                      label: "horas",
                                                      value: "2",
                                                      state: .green, 
                                                      habitPublisher: PassthroughSubject<Bool, Never>()))
          
            HabitCardView(isChart: false, viewModel: HabitCardViewModel(id: 1,
                                                      icon: "https://via.placeholder.com/150",
                                                      date: "01/01/2021 00:00:00",
                                                      name: "Tocar guitarra",
                                                      label: "horas",
                                                      value: "2",
                                                      state: .green,
                                                      habitPublisher: PassthroughSubject<Bool, Never>()))
            
        }.frame(maxWidth: .infinity)
        .navigationTitle("Teste")
        
      }
      
      .previewDevice("iPhone 11")
        .preferredColorScheme($0)
    }
  }
}
