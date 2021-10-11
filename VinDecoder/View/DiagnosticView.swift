//
//  DiagnosticView.swift
//  VinDecoder
//  Created by Sawyer Cherry on 3/18/21.
//

import SwiftUI

struct DiagnosticView: View {
    
    @State var dataDTC = DTCData(system: "", fault: "")
    
    @State var dtcURL = String()
    
    @State var searchDTC = String()
    
    @State var searchVIN = String()
    
    
    var body: some View {
        
        
        
        
        ScrollView {
            
            Text("DTC Decoder")
                .font(.system(size: 20))
                .padding(.top, 50)
                .padding(.bottom, 50)
            
            Text("\(dtcURL)")
                .onTapGesture {
                    let url = URL(string: dtcURL)
                    guard let  DTCUrl = url, UIApplication.shared.canOpenURL(DTCUrl) else {return}
                    UIApplication.shared.open(DTCUrl)
                }
            
            // refactored code and created group for the VIN, DTC, and the fetchAPI() button
            Group {
                TextField("Enter Your VIN", text: $searchVIN)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 35)
                
                TextField("Enter Your DTC", text: $searchDTC)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 35)
                
                Button("Fetch Data"){fetchAPI()}
                    .padding(.top, 30)
                    .padding(.bottom, 65)
            }
            
            // Refactored Group, This data is what the user will get from the API
            Group {
                Text("System:")
                Text("\(dataDTC.system)")
                    .padding(.bottom, 15)
                Text("Fault:")
                Text("\(dataDTC.fault)")
                    .padding(.bottom, 15)
            }
        }
    }
    
    
    
    func fetchAPI() {
        
        // This is where the magic happens...
        //The fetchAPI() function takes the user's entered VIN and the DTC. The API Key, and client secret and client ID (provided by me), and makes a request to the server, if the data can not be decoded properly inside of the structure, it will fail, leaving a message in the console.
        
        // *******************************************************
        // Use these for testing in the Diagnostic Decoder Tab
        // Avalanche VIN (First 11 Digits Only): 3GNVKEE06AG
        // Error code: P0521
        // *******************************************************
        
        
        let url = URL(string: "https://api.eu.apiconnect.ibmcloud.com/hella-ventures-car-diagnostic-api/api/v1/dtc?client_id=\(clientID)&client_secret=\(clientSecret)&code_id=\(self.searchDTC)&vin=\(self.searchVIN)&language=EN")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(DiagnosticData.self, from: data)
                    self.dataDTC = decodedData.dtc_data
                } catch {
                    print("ERROR! SOMETHING WENT WRONG!!!")
                }
                
            }
        }.resume()
    }
}

struct DTCStructure: Decodable {
    let data: [datasStructure]
}
struct datasStructure: Decodable {
    let url: String
}
