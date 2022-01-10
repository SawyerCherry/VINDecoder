//
//  AddVehicleView.swift
//  VinDecoder
//
//  Created by Sawyer Cherry on 1/10/22.
//

import SwiftUI

struct AddMaintenenceLogView: View {
    
    //: MARK: - Properties
    @State var title: String = ""
    @State var notes: String = ""
    @State var cost: Double = 0.00
    @State var date: String = ""
   
    
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Title")
                    Spacer()
                    TextField("enter", text: $title)
                        .fixedSize()
                }
                
                HStack {
                    Text("Notes")
                    Spacer()
                    TextField("enter", text: $notes)
                        .fixedSize()
                }
                
                HStack {
                    Text("Cost")
                    Spacer()
                    TextField("enter", value: $cost, format: .number)
                        .fixedSize()
                }
                
                HStack {
                    Text("date")
                    Spacer()
                    TextField("enter", text: $date)
                        .fixedSize()
                }
            }.navigationTitle("Add Maintenance Log")
        }
    }
}


