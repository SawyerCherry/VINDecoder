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
    @State var year: String = ""
    @State var color: String = ""
    @State var engine: String = ""
    @State var transmission: String = ""
    @State var driveType: String = ""
    @State var trim: String = ""
    @State var titleStatus: String = ""
    @State var vin: String = ""
    
    var body: some View {
     
         
                Form {
                    
                    HStack {
                        Text("Name")
                            .padding(.trailing, 23)
                        Spacer()
                        TextField("enter", text: $name)
                    }
                    
                    HStack {
                        Text("Make")
                            .padding(.trailing, 27)
                        Spacer()
                        TextField("enter", text: $make)
                    }
                    
                    HStack {
                        Text("Model")
                            .padding(.trailing, 22)
                        Spacer()
                        TextField("enter", text: $model)
                    }
                    
                    HStack {
                        Text("Year")
                            .padding(.trailing, 35)
                        Spacer()
                        TextField("enter", text: $year)
                            .keyboardType(.numberPad)
                    }
                    
                    HStack {
                        Text("Color")
                            .padding(.trailing, 27)
                        Spacer()
                        TextField("enter", text: $color)
                    }
                    
                    HStack {
                        Text("Engine")
                            .padding(.trailing, 17)
                        Spacer()
                        TextField("enter", text: $engine)
                    }
                    
                    HStack {
                        Text("Transmission")
                            .padding(.trailing)
                        Spacer()
                        TextField("enter", text: $transmission)
                        Spacer()
                    }
                    
                    HStack {
                        Text("Drive Type")
                            .padding(.trailing)
                        Spacer()
                        TextField("enter", text: $driveType)
                    }
                    
                    HStack {
                        Text("Trim")
                            .padding(.trailing, 33)
                        Spacer()
                        TextField("enter", text: $trim)
                    }
                    
                    Group {
                        HStack {
                            Text("Title Status")
                                .padding(.trailing)
                            Spacer()
                            TextField("enter", text: $titleStatus)
                        }
                        
                        HStack {
                            Text("VIN")
                                .padding(.trailing, 37)
                            Spacer()
                            TextField("enter", text: $vin)
                        }
                        HStack {
                            Spacer()
                            Button {
                                PersistenceController.shared.addVehicle(name: name, year: year, make: make, model: model, engine: engine, titleStatus: titleStatus, vin: vin, driveType: driveType, transmission: transmission, trim: trim, color: color)
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Text("Save")
                                    .padding(.horizontal, 16)
                                    .frame(width: 85, height: 45)
                                    .background(Color("honolulu"))
                                    .foregroundColor(Color.white)
                                    .cornerRadius(18)
                            }
                            Spacer()
                        }.padding()
                    }//: Group
                }//: Form
                .navigationBarTitle("Add Vehicle")
        }
}


struct AddVehicleView_Previews: PreviewProvider {
    static var previews: some View {
        AddVehicleView()
            .preferredColorScheme(.dark)
    }
}
