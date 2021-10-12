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
            return print("error, vin is not valid")
        }
        
        guard let url = URL(string: "https://vindecoder.p.rapidapi.com/v1.1/decode_vin?vin=\(sanitizeVIN)&rapidapi-key=\(apiKey)") else {
            return print("error :(")
        }
        fullVIN = sanitizeVIN
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                //                if let jsonString = String(data: data, encoding: .utf8) {
                //                    print(jsonString)
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(VehicleData.self, from: data)
                    DispatchQueue.main.async {
                        self.data = decodedData
                    }
                } catch {
                    print(error.localizedDescription)
                }
                //                }
            }
        }.resume()
    }
    
    private func santitizeAndValidateVIN(vin: String) -> String? {
        let trimmed = vin.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        // make sure to validate the sanitized VIN 17 chars
        guard trimmed.count == 17 else {
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
            
            ScrollView {
                
                HStack {
                    TextField("Enter or Scan your VIN", text: $model.fullVIN)
                   
                    Button("Fetch Data"){model.fetchCarData(from: model.fullVIN)}
                        .padding(.horizontal, 16)
                        .frame(height: 36)
                        .background(Color(UIColor.systemGreen))
                        .foregroundColor(Color.white)
                        .cornerRadius(18)
                  
                }
                .padding()
                
                // SwiftUI only lets you put 10 Texts in, you can put them in groups to fix this error, just split them up.
                
                //Regrouped Specifications
                Group {
                    Text("Year:")
                    Text("\(model.data.specification.year)")
                        .padding(.bottom, 15)
                    Text("Make:")
                    Text("\(model.data.specification.make)")
                        .padding(.bottom, 15)
                    Text("Model:")
                    Text("\(model.data.specification.model)")
                        .padding(.bottom, 15)
                    Text("Trim / Edition:")
                    Text("\(model.data.specification.trim_level)")
                        .padding(.bottom, 15)
                }
                
                //Regrouped Specifications
                Group {
                    Text("Engine Specifications:")
                    Text("\(model.data.specification.engine)")
                        .padding(.bottom, 15)
                    Text("Transmission Type:")
                    Text("\(model.data.specification.transmission)")
                        .padding(.bottom, 15)
                    
                    Text("Style:")
                    Text("\(model.data.specification.style)")
                        .padding(.bottom, 15)
                }
                
                //Regrouped Specifications
                Group {
                    Text("Manufactured In:")
                    Text("\(model.data.specification.made_in)")
                        .padding(.bottom, 15)
                    Text("Anti Brake Sysyem Type:")
                    Text("\(model.data.specification.anti_brake_system)")
                        .padding(.bottom, 15)
                    Text("Length of Vehicle:")
                    Text("\(model.data.specification.overall_length)")
                        .padding(.bottom, 15)
                    Text("Width of Vehicle:")
                    Text("\(model.data.specification.overall_width)")
                        .padding(.bottom, 15)
                }
                
                //Regrouped Specifications
                Group {
                    Text("Height of Vehicle:")
                    Text("\(model.data.specification.overall_height)")
                        .padding(.bottom, 15)
                    Text("Amount of Seats:")
                    Text("\(model.data.specification.optional_seating)")
                        .padding(.bottom, 15)
                    Text("Fuel Type:")
                    Text("\(model.data.specification.fuel_type)")
                        .padding(.bottom, 15)
                    Text("Highway MPG:")
                    Text("\(model.data.specification.highway_mileage)")
                        .padding(.bottom, 15)
                    Text("City MPG:")
                    Text("\(model.data.specification.city_mileage)")
                        .padding(.bottom, 15)
                    
                }
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
                .background(Color(UIColor.systemGreen))
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
    }
}
