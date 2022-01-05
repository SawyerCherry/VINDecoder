//
//  ContentView.swift
//  VinDecoder
//
//  Created by Sawyer Cherry on 3/15/21.
//


//: MARK: - VIN For Testing
    // *******************************************************
    // Use for this full VIN for testing in the Vin Decoder Tab
    // Avalanche FULL VIN: 3GNVKEE06AG274555
    // *******************************************************

import SwiftUI

class ContentViewModel: ObservableObject {
    
    @Published var items = [TextItem]()
    
    @Published var fullVIN = String()
    
    @Published var isAlerting = false
    
    @Published var alertingFromServer = false
    
    @Published var data = VehicleData(vin: "", specification: SpecificationData(make: "", year: "", model: "", engine: "", trim_level: "", made_in: "", drive_type: "", fuel_type: "", overall_height: "", overall_length: "", overall_width: "", highway_mileage: "", city_mileage: "", transmission: "", style: "", anti_brake_system: "", optional_seating: ""))
    
    private let textRecognizer = TextRecognition()
    
    func recognize(image: UIImage, completion: @escaping () -> Void) {
        textRecognizer.recognizeText(from: image) { result in
            
            switch result {
            case .success(let string):
                self.fetchCarData(from: string)
            case .failure(let error):
                print(error.localizedDescription)
            }
            completion()
        }
    }
    
    func fetchCarData(from vin: String) {
        guard let sanitizeVIN = santitizeAndValidateVIN(vin: vin) else {
            isAlerting = true
            return print("error, vin is not valid")
        }
        
        guard let url = URL(string: "https://vindecoder.p.rapidapi.com/v1.1/decode_vin?vin=\(sanitizeVIN)&rapidapi-key=\(apiKey)") else {
            return print("error :(")
        }
        fullVIN = sanitizeVIN
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(VehicleData.self, from: data)
                    DispatchQueue.main.async {
                        self.data = decodedData
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.alertingFromServer = true
                    }
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    private func santitizeAndValidateVIN(vin: String) -> String? {
        let trimmed = vin.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        // make sure to validate the sanitized VIN 17 or 12 chars
        guard trimmed.count == 17 || trimmed.count == 12 else{
            return nil
        }
        
        return trimmed
    }
}

struct ContentView: View {
    
    @State private var showScanner = false
    @State private var isRecognizing = false
    
   
    @StateObject var model = ContentViewModel()
    
    var body: some View {
        
        NavigationView {
            
            ScrollView(showsIndicators: false) {
                
                HStack {
                    TextField("Enter or Scan your VIN", text: $model.fullVIN)
                   
                    Button("Fetch Data"){model.fetchCarData(from: model.fullVIN)}
                        .padding(.horizontal, 16)
                        .frame(height: 36)
                        .background(Color("honolulu"))
                        .foregroundColor(Color.white)
                        .cornerRadius(18)
                  
                }
                .padding()
                
                // SwiftUI only lets you put 10 Texts in, you can put them in groups to fix this error, just split them up.
                
                //Regrouped Specifications
                GroupBox(label: HeaderView(labelText: "Basic Info", labelImage: "info.circle")) {
                    
                    DataRowView(title: "Year", data: model.data.specification.year)
        
                    DataRowView(title: "Make", data: model.data.specification.make)
             
                    DataRowView(title: "Model", data: model.data.specification.model)
                  
                    DataRowView(title: "Trim Level", data: model.data.specification.trim_level)
                    
                }.padding()
                
                //Regrouped Specifications
                GroupBox(label: HeaderView(labelText: "Mechanical", labelImage: "info.circle")) {
                    
                    DataRowView(title: "Engine", data: model.data.specification.engine)
                    
                    DataRowView(title: "Transmission", data: model.data.specification.transmission)
                    
                    DataRowView(title: "Drive Type", data: model.data.specification.drive_type)
                    
                    DataRowView(title: "Anti Brake System", data: model.data.specification.anti_brake_system)
                    
                }.padding()
                
                GroupBox(label: HeaderView(labelText: "Fuel", labelImage: "info.circle")) {
                    
                    DataRowView(title: "Fuel Type", data: model.data.specification.fuel_type)
                    
                    DataRowView(title: "Highway MPG", data: model.data.specification.highway_mileage)
                    
                    DataRowView(title: "City MPG", data: model.data.specification.city_mileage)
                    
                }.padding()
                
                GroupBox(label: HeaderView(labelText: "Specifications", labelImage: "info.circle")) {
                    
                    DataRowView(title: "Style", data: model.data.specification.style)
                    
                    DataRowView(title: "Seating", data: model.data.specification.optional_seating)
                    
                    DataRowView(title: "Made In", data: model.data.specification.made_in)
                    
                }.padding()
                //Regrouped Specifications
                GroupBox(label: HeaderView(labelText: "Measurements", labelImage: "info.circle")) {
                  
                    DataRowView(title: "Length", data: model.data.specification.overall_length)
                    
                    DataRowView(title: "Width", data: model.data.specification.overall_width)
                    
                    DataRowView(title: "Height", data: model.data.specification.overall_height)
                }.padding()
                
            }
            .navigationTitle("Vin Decoder")
            .navigationBarItems(trailing: Button(action: {
                guard !isRecognizing else { return }
                showScanner = true
            }, label: {
                HStack {
                    Image(systemName: "doc.text.viewfinder")
                        .renderingMode(.template)
                        .foregroundColor(.white)
                    
                    Text("Scan VIN")
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 16)
                .frame(height: 36)
                .background(Color("honolulu"))
                .cornerRadius(18)
            }))
            .padding()
        }
        .navigationTitle("VIN Decoder")
        .sheet(isPresented: $showScanner, content: {
            ScannerView { result in
                switch result {
                case .success(let scannedImage):
                    isRecognizing = true
                    model.recognize(image: scannedImage[0]) {
                        isRecognizing = false
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                showScanner = false
            } didCancelScanning: {
                // Dismiss the scanner controller and the sheet.
                showScanner = false
            }
            
        })
        .alert("VIN is invalid", isPresented: $model.isAlerting) {
            Button("OK", role: .cancel) { }
        }
        .alert("Sorry, API bad", isPresented: $model.alertingFromServer) {
            Button("OK", role: .cancel) { }
        }
        
    }
    
}

// these two structures are for decoding the URL to make the API Call.
struct VINStructure: Decodable {
    let data: [dataStructure]
}
struct dataStructure: Decodable {
    let url: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
