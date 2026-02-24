//
//  ContentView.swift
//  Dogs
//
//  Created by david thompson on 2/24/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: "https://images.dog.ceo/breeds/poodle-miniature/n02113712_10525.jpg")){ img in
                if let error = img.error{
                    Text("We Have An Error")
                    Text("\(error.localizedDescription)")
                }
                
                if let image = img.image{
                    image
                        .resizable()
                        .frame(width: 201, height: 201)
                    
                }
            }
            
            Text("Our Dog?")
                .bold()
                .font(.largeTitle)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()

    }
}

#Preview {
    ContentView()
}
