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
                HStack {
                    Text("Add to Vehicle")
                    Spacer()
                    Picker("Vehicles", selection: $selectedVehicle) {
                        ForEach(items) { vehicle in
                            Text(vehicle.name!)
                                .tag(vehicle as Vehicle?)
                        }
                    }.pickerStyle(.menu)
                }.padding(.horizontal, 75)
                HStack {
                    Text("Title")
                    Spacer()
                    TextField("enter", text: $title)
                        .fixedSize()
                }.padding(.horizontal, 75)
                
                HStack {
                    Text("Notes")
                    Spacer()
                    TextField("enter", text: $notes)
                        .fixedSize()
                }.padding(.horizontal, 75)
                
                HStack {
                    Text("Cost")
                    Spacer()
                    TextField("enter", value: $cost, format: .number)
                        .fixedSize()
                }.padding(.horizontal, 75)
                
                HStack {
                    Text("date")
                    Spacer()
                    TextField("enter", text: $date)
                        .fixedSize()
                }.padding(.horizontal, 75)
                
                Button {
                    PersistenceController.shared.addMaintenanceLog(cost: cost, date: date, notes: notes, title: title, into: selectedVehicle)
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Save")
                        .padding(.horizontal, 16)
                        .frame(width: 85, height: 45)
                        .background(Color("honolulu"))
                        .cornerRadius(18)

                }.padding(.top, 100)
                
            }.navigationTitle("Add Maintenance Log")
        }.onAppear {
            let firstVehicle = PersistenceController.shared.findVehicles()
            self.selectedVehicle = firstVehicle
        }
    }
}


