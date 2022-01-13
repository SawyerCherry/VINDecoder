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

struct CreateView: View {
    //: MARK: - Properties
    
    @State private var showingAddVehicle: Bool = false
    @State private var showingVehicleDetail: Bool = false
    
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Vehicle.name, ascending: false)],
        animation: .default)
    
    private var vehicles: FetchedResults<Vehicle>
    
    @StateObject var model = CreateViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vehicles) { vehicle in
                    VehicleView(vehicle: vehicle)
                }
                .background(Color("honolulu"))
                .cornerRadius(8)
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

struct VehicleView: View {
    @ObservedObject var vehicle: Vehicle
  
    @State private var showingVehicleDetail = false

    var body: some View {
        GroupBox(label: HeaderView(labelText: vehicle.name!, labelImage: "fingerprint")) {
            Divider()
                HStack {
                    Text("\(vehicle.year!) \(vehicle.make!) \(vehicle.model!)")
                    Spacer()
                    
                    NavigationLink(destination: VehicleDetailView(vehicle: vehicle), isActive: $showingVehicleDetail) {
                        Button(action: {
                            showingVehicleDetail = true
                        }) {
                            Text("Details")
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


struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
