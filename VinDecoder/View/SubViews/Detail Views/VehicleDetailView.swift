//
//  VehicleDetailView.swift
//  VinDecoder
//
//  Created by Sawyer Cherry on 1/12/22.
//

import SwiftUI
import CoreData

class VehicleDetailViewModel: ObservableObject {
    @Published var numberOfLogs: Int
    
    var notification: NSObjectProtocol!
    
    init() {
        self.numberOfLogs = PersistenceController.shared.numberOfMaintenanceLogs()
        
        notification = NotificationCenter.default.addObserver(forName: NSManagedObjectContext.didChangeObjectsNotification, object: nil, queue: .main, using: { _ in
            self.numberOfLogs = PersistenceController.shared.numberOfMaintenanceLogs()
        })
    }
}

struct VehicleDetailView: View {
    @ObservedObject var vehicle: Vehicle
    
    @State private var showingAddMaintenanceLog: Bool = false
    @State private var showingMaintenceLogDetails: Bool = false
    @StateObject var model = VehicleDetailViewModel()
    
    var body: some View {
        ScrollView {
            GroupBox(label: HeaderView(labelText: "\(vehicle.year!) \(vehicle.make!) \(vehicle.model!)", labelImage: "info.circle")) {
                Divider()
                    
                HStack {
                    Text("Engine Spec:")
                    Text(vehicle.engine!)
                    Spacer()
                }
                Divider()
                HStack {
                    Text("Transmission:")
                    Text(vehicle.transmission!)
                    Spacer()
                }
                Divider()
                HStack {
                    Text("Drive Type:")
                    Text(vehicle.driveType!)
                    Spacer()
                }
                Group {
                    Divider()
                    HStack {
                        Text("Trim/Edition:")
                        Text(vehicle.trim!)
                        Spacer()
                    }
                    Divider()
                    HStack {
                        Text("Color:")
                        Text(vehicle.color!)
                        Spacer()
                    }
                    Divider()
                    HStack {
                        Text("Title Status:")
                        Text(vehicle.titleStatus!)
                        Spacer()
                    }
                    Divider()
                    HStack {
                        Text("VIN:")
                        Text(vehicle.vin!)
                        Spacer()
                    }
                    
                    NavigationLink(destination: MaintenanceLogDetailView(vehicle: vehicle), isActive: $showingMaintenceLogDetails) {
                        Button(action: {
                            showingMaintenceLogDetails = true
                        }) {
                            Text("Maintenance Logs")
                                .padding(.horizontal, 16)
                                .frame(height: 36)
                                .background(Color("honolulu"))
                                .foregroundColor(Color.white)
                                .cornerRadius(18)
                                .padding()
                        }
                        
                        
                            
                        
                    }.disabled(model.numberOfLogs == 0)
                    
                }
                
            }//: GroupBox
            .tag(vehicle as Vehicle?)
            .navigationTitle("\(vehicle.name!)")
            .padding()
            
            
        }//: VStack
        .navigationBarItems(trailing: Button(action: {
            showingAddMaintenanceLog = true
        }, label: {
            HStack {
                Text("Log Maintenance")
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 16)
            .frame(height: 36)
            .background(Color("honolulu"))
            .cornerRadius(18)
        }))
        .sheet(isPresented: $showingAddMaintenanceLog) {
            AddMaintenenceLogView()
                .navigationTitle("Maintenance Log")
        }
        
        
    }
}


