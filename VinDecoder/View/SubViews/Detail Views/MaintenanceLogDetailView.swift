//
//  MaintenanceLogDetailView.swift
//  VinDecoder
//
//  Created by Sawyer Cherry on 1/12/22.
//

import SwiftUI

extension Vehicle {
    var getAllMaintenence: [MaintenanceLog] {
        return maintenanceLogs!.allObjects as! [MaintenanceLog]
    }
}
struct MaintenanceLogDetailView: View {
    
    var vehicle: Vehicle
    
    var body: some View {
        ScrollView {
            ForEach(vehicle.getAllMaintenence) { log in
                MaintenanceCardView(maintenanceLog: log)
            }//:Loop
        }//:Loop
        .navigationTitle("Maintenance Logs")
    }
}

struct MaintenanceCardView: View {
    
    @ObservedObject var maintenanceLog: MaintenanceLog
    
    var body: some View {
        GroupBox(label: HeaderView(labelText: "Maintenence Log", labelImage: "wrench.and.screwdriver")) {
            Divider()
            VStack {
                HStack {
                    Text("Date:")
                    Text(maintenanceLog.date!)
                    Spacer()
                }
                Divider()
                HStack {
                    Text("Title:")
                    Text(maintenanceLog.title!)
                    Spacer()
                }
                Divider()
                HStack {
                    Text("Notes:")
                    ScrollView {
                        Text(maintenanceLog.notes!)
                    }
                    Spacer()
                }
                Divider()
                HStack {
                    Text("Cost:")
                    Text("$\(maintenanceLog.cost, specifier: "%.2f")")
                    Spacer()
                }
            }//:Stack
        }.padding()
    }
}


