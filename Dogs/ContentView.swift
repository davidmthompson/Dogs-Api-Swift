//
//  ContentView.swift
//
//  Dogs
//
//  Created by david thompson on 2/24/26.
//

import SwiftUI

struct ContentView: View {
    @State var dogoImage: URL?
    
    var body: some View {
        VStack {
            AsyncImage(url: dogoImage) { img in
                if let error = img.error {
                    Text("We Have An Error")
                    Text("\(error.localizedDescription)")
                }
                
                if let image = img.image {
                    image
                        .resizable()
                        .frame(width: 501, height: 501)
                        .cornerRadius(20)
                }
            }
            
            Text("Our Dog?")
                .bold()
                .font(.largeTitle)
            
            
            
            Button {
                Task {
                    let ourData = await getSeverData()
                    if let message = ourData?.message {
                        dogoImage = URL(string: message)
                    }
                }
            } label: {
                Text("Feach New Dog!")
                    .font(.title)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .task {
            
            
                await fetchDog()
                }
    }
    
    func fetchDog() async {
            let ourData = await getSeverData()
            if let message = ourData?.message {
                dogoImage = URL(string: message)
            }
        }
}

func getSeverData() async -> SeverResponse? {
    do {
        guard let severURL = URL(string: "https://dog.ceo/api/breeds/image/random") else {
            return nil
        }
        let (data, response) = try await URLSession.shared.data(from: severURL)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            print("we got a bad status code!")
            return nil
        }
        
        let decode = try JSONDecoder().decode(SeverResponse.self, from: data)
        return decode
    } catch {
        print(error)
    }
    return nil
}

struct SeverResponse: Codable {
    let message: String
    let status: String
}

#Preview {
    ContentView()
}
