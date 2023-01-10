//
//  ContentView.swift
//  Movies
//
//  Created by Elaidzha Shchukin on 09.01.2023.
//

import SwiftUI

struct ContentView: View {
    
    class ViewModel: ObservableObject {
        @Published var image: Image ?
        
        func fetchNewImage() {
            guard let url = URL(string:
                                    "https://random.imagecdn.app/500/500") else {
                return
            }
            let task = URLSession.shared.data.dataTask(with: url) { data,
                 _, _ in
                guard let data = data else { return }
                
                DispatchQueue.main.async {
                    let uiImage = UIImage(data: data)
                }
            }
        }
    }
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Spacer()
                
                Image(systemName: "photo")
                    .resizable()
                    .foregroundColor(.brown)
                    .frame(width: 400, height: 450)
                    .padding()
                
                Spacer()
                
                Button {
                    print()
                } label: {
                    Text("New Movie")
                        .font(.title3)
                        .frame(width: 200, height: 50)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(12)
                        .padding()
                }

            }
            .navigationTitle("Movies")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
