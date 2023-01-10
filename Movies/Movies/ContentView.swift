//
//  ContentView.swift
//  Movies
//
//  Created by Elaidzha Shchukin on 09.01.2023.
//

import SwiftUI

class ViewModel: ObservableObject {
    
    @Published var image: Image?
    
    func fetchNewImage() {
        guard let url = URL(string:
                                "https://random.imagecdn.app/500/500") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                guard let uiImage = UIImage(data: data) else {
                    return
                }
                self.image = Image(uiImage: uiImage)
            }
        }
        task.resume()
    }
}

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                Spacer()
                
                if let image = viewModel.image {
                    ZStack {
                        image
                            .resizable()
                            .foregroundColor(.brown)
                            .frame(width: 400, height: 450)
                            .padding()
                    }
                    .frame(width: UIScreen.main.bounds.width / 1.1,
                           height: UIScreen.main.bounds.width / 1.2)
                    .background(Color.black)
                    .cornerRadius(12)
                } else {
                    
                    Image(systemName: "photo")
                        .resizable()
                        .foregroundColor(.brown)
                        .frame(width: 400, height: 450)
                        .padding()
                }
                Spacer()
                
                Button {
                    viewModel.fetchNewImage()
                } label: {
                    Text("New Movie")
                        .font(.title3)
                        .frame(width: 200, height: 50)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .background(Color.brown)
                        .cornerRadius(12)
                        .padding()
                }
            }
            .background(Color.gray)
            .navigationTitle("Movies")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
