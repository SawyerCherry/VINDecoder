//
//  AddMaintenanceLogView.swift
//  VinDecoder
//
//  Created by Sawyer Cherry on 1/10/22.
//

import SwiftUI

struct AddVehicleView: View {
    //: MARK: - Properties
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var name: String = ""
    @State var make: String = ""
    @State var model: String = ""
    @State var year: Int = 0
    @State var color: String = ""
    @State var engine: String = ""
    @State var transmission: String = ""
    @State var driveType: String = ""
    @State var trim: String = ""
    @State var titleStatus: String = ""
    @State var vin: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Name")
                    Spacer()
                    TextField("enter", text: $name)
                }.padding(.horizontal, 100)
                
                HStack {
                    Text("Make")
                    Spacer()
                    TextField("enter", text: $make)
                }.padding(.horizontal, 100)
                
                HStack {
                    Text("Model")
                    Spacer()
                    TextField("enter", text: $model)
                }.padding(.horizontal, 100)
                
                HStack {
                    Text("Year")
                    Spacer()
                    TextField("enter", value: $year, format: .number)
                }.padding(.horizontal, 100)
                
                HStack {
                    Text("Color")
                    Spacer()
                    TextField("enter", text: $color)
                }.padding(.horizontal, 100)
                
                HStack {
                    Text("Engine")
                    Spacer()
                    TextField("enter", text: $engine)
                }.padding(.horizontal, 100)
                
                HStack {
                    Text("Transmission")
                    Spacer()
                    TextField("enter", text: $transmission)
                }.padding(.horizontal, 100)
                
                HStack {
                    Text("Drive Type")
                    Spacer()
                    TextField("enter", text: $driveType)
                }.padding(.horizontal, 100)
                
                HStack {
                    Text("Trim")
                    Spacer()
                    TextField("enter", text: $trim)
                }.padding(.horizontal, 100)
                
                Group {
                    HStack {
                        Text("Title Status")
                        Spacer()
                        TextField("enter", text: $titleStatus)
                    }.padding(.horizontal, 100)
                    
                    HStack {
                        Text("VIN")
                        Spacer()
                        TextField("enter", text: $vin)
                    }.padding(.horizontal, 100)
                
                    Button {
                        PersistenceController.shared.addVehicle(name: name, year: year, make: make, model: model, engine: engine, titleStatus: titleStatus, vin: vin, driveType: driveType, transmission: transmission, trim: trim, color: color)
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save")
                            .padding(.horizontal, 16)
                            .frame(width: 85, height: 45)
                            .background(Color("saddleBrown"))
                            .foregroundColor(Color.white)
                            .cornerRadius(18)
                    }
                }//: Group
                
                
            }.navigationTitle("Add Vehicle")
        }
    }
}

