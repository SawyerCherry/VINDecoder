//
//  AddVehicleView.swift
//  VinDecoder
//
//  Created by Sawyer Cherry on 1/10/22.
//

import SwiftUI
import CoreData

struct AddMaintenenceLogView: View {
    
    //: MARK: - Properties
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var title: String = ""
    @State var notes: String = ""
    @State var cost: Double = 0.00
    @State var date: String = ""
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Vehicle.name, ascending: false)], animation: .default)
    
    private var items: FetchedResults<Vehicle>
    
    @State var selectedVehicle: Vehicle!
    
    var body: some View {
        NavigationView {
            VStack {
                
                Form {
                    HStack {
                        Text("Add to Vehicle")
                        Spacer()
                        Picker("Vehicles", selection: $selectedVehicle) {
                            ForEach(items) { vehicle in
                                Text(vehicle.name!)
                                    .tag(vehicle as Vehicle?)
                            }
                        }.pickerStyle(.menu)
                    }
                    HStack {
                        Text("Title")
                            .padding(.trailing, 27)
                        TextField("enter", text: $title)
                        
                    }
                    HStack {
                        Text("Notes")
                            .padding(.trailing)
                        TextField("enter", text: $notes)
                        
                    }
                    HStack {
                        Text("Cost")
                            .padding(.trailing, 27)
                        TextField("enter", value: $cost, format: .currency(code: "$0.00"))
                        
                    }
                    
                    HStack {
                        Text("Date")
                            .padding(.trailing, 27)
                        TextField("enter", text: $date)
                    }
                    HStack {
                        Spacer()
                        Button {
                            PersistenceController.shared.addMaintenanceLog(cost: cost, date: date, notes: notes, title: title, into: selectedVehicle)
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Save")
                                .padding(.horizontal, 16)
                                .frame(width: 85, height: 45)
                                .background(Color("honolulu"))
                                .foregroundColor(Color.black)
                                .cornerRadius(18)
                            
                        }
                        .padding()
                        Spacer()
                    }
                }
                
            }.navigationTitle("Add Maintenance Log")
                .padding(.top)
        }.onAppear {
            let firstVehicle = PersistenceController.shared.findVehicles()
            self.selectedVehicle = firstVehicle
        }
    }
}


struct AddMaintenanceLogView_Previews: PreviewProvider {
    static var previews: some View {
        AddMaintenenceLogView()
            .preferredColorScheme(.dark)
    }
}
