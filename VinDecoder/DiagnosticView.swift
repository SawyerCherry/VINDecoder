//
//  DiagnosticView.swift
//  VinDecoder
//  Created by Sawyer Cherry on 3/18/21.
//

import SwiftUI

struct DiagnosticView: View {
    
    @State var data = DTCData(system: "", fault: "")
    
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
            
            TextField("Enter Your VIN", text: $searchVIN)
                .multilineTextAlignment(.center)
                .padding(.bottom, 35)
            
            
            TextField("Enter Your DTC", text: $searchDTC)
                .multilineTextAlignment(.center)
                .padding(.bottom, 35)
            
            
            Button("Fetch Data"){fetchAPI()}
                .padding(.top, 30)
                .padding(.bottom, 65)
            
            
            
            Group {
                

                Text("System:")
                Text("\(data.system)")
                    .padding(.bottom, 15)
                    .padding(.top, 50)
                Text("Fault:")
                Text("\(data.fault)")
                    .padding(.bottom, 15)
                
            }
        }
    }

    
    
    func fetchAPI() {
        
        // *******************************************************
        // Use these for testing in the Diagnostic Decoder Tab
        // Avalanche VIN (First 11 Digits Only): 3GNVKEE06AG
        // Error code: P0521
        // *******************************************************
        
        let clientSecret = "uM8sD1sC0mA6jN6sP0iN3uF8eU7kT8sU0lX5xF8mS2iA1cQ6tR"
        
        let clientID = "5225f0af-90d1-45f8-a9ef-acf38631b650"
        
        let url = URL(string: "https://api.eu.apiconnect.ibmcloud.com/hella-ventures-car-diagnostic-api/api/v1/dtc?client_id=\(clientID)&client_secret=\(clientSecret)&code_id=\(self.searchDTC)&vin=\(self.searchVIN)&language=EN")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print(jsonString)
                    do {
                        
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(DTCData.self, from: data)
                        self.data = decodedData // Broke on this line 
                        
                        
                    } catch {
                        
                        print("Stupid Unknown Error")
                    }
                    if let decodedDTC = try? JSONDecoder().decode(DTCStructure.self, from: data){
                        self.dtcURL = decodedDTC.data[0].url
                    }
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
