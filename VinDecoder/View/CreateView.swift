//
//  CreateView.swift
//  VinDecoder
//
//  Created by Sawyer Cherry on 1/5/22.
//

import SwiftUI
import CoreData

class CreateViewModel: ObservableObject {
    @Published var numberOfVehicles: Int
    
    var notification: NSObjectProtocol!
    
    init() {
        self.numberOfVehicles = PersistenceController.shared.numberofVehicles()
        
        notification = NotificationCenter.default.addObserver(forName: NSManagedObjectContext.didChangeObjectsNotification, object: nil, queue: .main, using: { _ in
            self.numberOfVehicles = PersistenceController.shared.numberofVehicles()
        })
    }
}


//extension Herd {
//    var getLivestockOnFarm: [Livestock] {
//        return livestockInHerd!.allObjects as! [Livestock]
//    }
//}


struct CreateView: View {
    //: MARK: - Properties
    @StateObject var model = CreateViewModel()
    @State private var showingAddVehicle: Bool = false
    @State private var showingVehicleDetail: Bool = false
    
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Vehicle.name, ascending: false)],
        animation: .default)
    
    private var vehicles: FetchedResults<Vehicle>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vehicles) { vehicle in
                    GroupBox(label: HeaderView(labelText: vehicle.name!, labelImage: "fingerprint")) {
                      
                        Divider()
                        VStack {
                            HStack {
                                Text("\(vehicle.year!) \(vehicle.make!) \(vehicle.model!)")
                                Spacer()
                                Button(action: {
                                    showingVehicleDetail = true
                                }) {
                                    Text("wee")
                                        .padding(.horizontal, 16)
                                        .frame(height: 36)
                                        .background(Color("honolulu"))
                                        .foregroundColor(Color.white)
                                        .cornerRadius(18)
                                        .padding()
                                }
                            }
                            
                        }
                        
                        
                       
                    }.padding()
                    
                }
                
            }
            .navigationTitle("Vehicles")
            .navigationBarItems(trailing: Button(action: {
                showingAddVehicle = true
            }, label: {
                HStack {
                    Image(systemName: "plus")
                        .renderingMode(.template)
                        .foregroundColor(.white)
                    
                    Text("Add")
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 16)
                .frame(height: 36)
                .background(Color("honolulu"))
                .cornerRadius(18)
            }))
            .sheet(isPresented: $showingAddVehicle) {
                AddVehicleView()
                    .navigationTitle("Add Vehicle")
            }
        
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
