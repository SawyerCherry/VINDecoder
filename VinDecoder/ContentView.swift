//
//  ContentView.swift
//  VinDecoder
//
//  Created by Sawyer Cherry on 3/15/21.
//

import SwiftUI

struct ContentView: View {
    @State var data = VehicleData(vin: "7877378hju3gu", specification: SpecificationData(make: "GMC", year: "2003", model: "Sierra 1500", engine: "EcoTech 5.3 V8 FlexFuel", trim_level: "Denali", made_in: "Mexico", drive_type: "AWD", fuel_type: "Gasoline", overall_height: "72.99", overall_length: "143.552", overall_width: "74.88", highway_mileage: "22 MPG", city_mileage: "17 MPG", transmission: "Automatically Systematically", style: "4 Door Crew Cab", anti_brake_system: "4 Wheel A-B-S", optional_seating: "6"))

    @State var vinURL = String()
    
    @State var searchString = String()
    
    
    
    var body: some View {
        Text("\(vinURL)")
            .onTapGesture {
                let url = URL(string: vinURL)
                guard let  VINUrl = url, UIApplication.shared.canOpenURL(VINUrl) else {return}
                UIApplication.shared.open(VINUrl)
            }
        
        
        ScrollView {
            
            TextField("Search VIN", text: $searchString)
                .padding(/*@START_MENU_TOKEN@*/[.top, .leading, .bottom]/*@END_MENU_TOKEN@*/)
    
            Button("Fetch Data"){fetchAPI()}
                .padding(.all, 5.0)
            
            // SwiftUI only lets you put 10 Texts in, you can put them in groups to fix this error, just split them up.
            Group {
                
                Text("Year:")
                Text("\(data.specification.year)")
                    .padding(.bottom, 15)
                Text("Make:")
                Text("\(data.specification.make)")
                    .padding(.bottom, 15)
                Text("Model:")
                Text("\(data.specification.model)")
                    .padding(.bottom, 15)
                Text("Trim / Edition:")
                Text("\(data.specification.trim_level)")
                    .padding(.bottom, 15)
                Text("Engine Specifications:")
                Text("\(data.specification.engine)")
                    .padding(.bottom, 15)
                
            }
            
            Group {
                
                Text("Style:")
                Text("\(data.specification.style)")
                    .padding(.bottom, 15)
                Text("Manufactured In:")
                Text("\(data.specification.made_in)")
                    .padding(.bottom, 15)
                Text("Anti Brake Sysyem Type:")
                Text("\(data.specification.anti_brake_system)")
                    .padding(.bottom, 15)
                Text("Length of Vehicle:")
                Text("\(data.specification.overall_length)")
                    .padding(.bottom, 15)
                Text("Width of Vehicle:")
                Text("\(data.specification.overall_width)")
                    .padding(.bottom, 15)
                
            }
            
            Group {
                
                Text("Height of Vehicle:")
                Text("\(data.specification.overall_height)")
                    .padding(.bottom, 15)
                Text("Amount of Seats:")
                Text("\(data.specification.optional_seating)")
                    .padding(.bottom, 15)
                Text("Fuel Type:")
                Text("\(data.specification.fuel_type)")
                    .padding(.bottom, 15)
                Text("Highway MPG:")
                Text("\(data.specification.highway_mileage)")
                    .padding(.bottom, 15)
                Text("City MPG:")
                Text("\(data.specification.city_mileage)")
                    .padding(.bottom, 15)
                
            }
            
        }
    }
    
    func fetchAPI() {
        let vinPlug = "3GNVKEE06AG274555"
        self.searchString = vinPlug
        let apiKey = "f9789218a6msh138da99e0f5a873p1e4e91jsn73c933512057"
        let url = URL(string: "https://vindecoder.p.rapidapi.com/v1.1/decode_vin?vin=\(self.searchString)&rapidapi-key=\(apiKey)")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print(jsonString)
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
