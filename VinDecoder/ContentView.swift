//
//  ContentView.swift
//  VinDecoder
//
//  Created by Sawyer Cherry on 3/15/21.
//

import SwiftUI

struct ContentView: View {
    @State var data = VehicleData(vinData: VINData(vin: "7877378hju3gu"), specData: SpecificationData(make: "Ford"))
    @State var vinURL = String()
    @State var searchString = String()
    
    
    
    var body: some View {
        Text("\(vinURL)")
            .onTapGesture {
                let url = URL(string: vinURL)
                guard let  VINUrl = url, UIApplication.shared.canOpenURL(VINUrl) else {return}
                UIApplication.shared.open(VINUrl)
            }
        
        
        VStack{
            TextField("Search VIN", text: $searchString)
            Button("Fetch Data"){fetchAPI()}
            Text("\(data.specData.make)")
        }
    }
    
    func fetchAPI() {
// let vinPlug = "3GNVKEE06AG274555"
        let apiKey = "f9789218a6msh138da99e0f5a873p1e4e91jsn73c933512057"
        let url = URL(string: "https://vindecoder.p.rapidapi.com/v1.1/decode_vin?vin=\(self.searchString)&rapidapi-key=\(apiKey)")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            DispatchQueue.main.async {

                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(VehicleData.self, from: data)
                        self.data = decodedData// Something is broke on this line
                    } catch {
                        print("ERROR! SOMETHING WENT WRONG!!!")
                    }
                    if let decodedVIN = try? JSONDecoder().decode(VINStructure.self, from: data){
                        self.vinURL = decodedVIN.data[0].url
                    }
                }
            }
        }.resume()
    }
}

struct VINStructure: Decodable {
    let data: [dataStructure]
}
struct dataStructure: Decodable {
    let url: String
}
