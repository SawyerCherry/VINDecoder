//
//  ContentView.swift
//  VinDecoder
//
//  Created by Sawyer Cherry on 3/15/21.
//

import SwiftUI

struct ContentView: View {
    // Just some empty dummy data, so that the API will replace them as needed.
    @State var data = VehicleData(vin: "", specification: SpecificationData(make: "", year: "", model: "", engine: "", trim_level: "", made_in: "", drive_type: "", fuel_type: "", overall_height: "", overall_length: "", overall_width: "", highway_mileage: "", city_mileage: "", transmission: "", style: "", anti_brake_system: "", optional_seating: ""))
    
    @State var vinURL = String()
    @State var searchString = String()
    
    var body: some View {
        
        ScrollView {
            
            Text("VIN Decoder")
                .font(.system(size: 20))
                .padding(.top, 50)
                .padding(.bottom, 50)
            
            Text("\(vinURL)")
                .onTapGesture {
                    let url = URL(string: vinURL)
                    guard let  VINUrl = url, UIApplication.shared.canOpenURL(VINUrl) else {return}
                    UIApplication.shared.open(VINUrl)
                }
            
            // this is an instance of where the user can enter their VIN
            TextField("Enter Your VIN", text: $searchString)
                .multilineTextAlignment(.center)
                .padding(.bottom, 35)
            
            //this button, when tapped, calls on the fetch API function.
            Button("Fetch Data"){fetchAPI()}
                .padding(.all, 5.0)
            
            // SwiftUI only lets you put 10 Texts in, you can put them in groups to fix this error, just split them up.
            
            //Regrouped Specifications
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
            }
            
           //Regrouped Specifications
            Group {
                Text("Engine Specifications:")
                Text("\(data.specification.engine)")
                    .padding(.bottom, 15)
                Text("Transmission Type:")
                Text("\(data.specification.transmission)")
                    .padding(.bottom, 15)
                
                Text("Style:")
                Text("\(data.specification.style)")
                    .padding(.bottom, 15)
            }
            
            //Regrouped Specifications
            Group {
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
            
            //Regrouped Specifications
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
        
        // The fetchAPI() function takes the user's entered VIN and the API Key (provided by me), and makes a request to the server, if the data can not be decoded properly inside of the structure, it will fail, leaving a message in the console.
        
        // *******************************************************
        // Use for this full VIN for testing in the Vin Decoder Tab
        // Avalanche FULL VIN: 3GNVKEE06AG274555
        // *******************************************************
        
       
        let url = URL(string: "https://vindecoder.p.rapidapi.com/v1.1/decode_vin?vin=\(self.searchString)&rapidapi-key=\(apiKey)")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print(jsonString)
                    do {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(VehicleData.self, from: data)
                        self.data = decodedData
                    } catch {
                        print("ERROR! SOMETHING WENT WRONG!!!")
                    }
                    if let decodedVIN = try? JSONDecoder().decode(VINStructure.self, from: data){
                        self.vinURL = decodedVIN.data[0].url
                    }
                }
            }
        }.resume() //we use .resume() to ensure that the API go if tapped again.
    }
}

// these two structures are for decoding the URL to make the API Call.
struct VINStructure: Decodable {
    let data: [dataStructure]
}
struct dataStructure: Decodable {
    let url: String
}
