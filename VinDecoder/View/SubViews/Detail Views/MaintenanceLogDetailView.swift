//
//  MaintenanceLogDetailView.swift
//  VinDecoder
//
//  Created by Sawyer Cherry on 1/12/22.
//

import SwiftUI

extension MaintenanceLog {
    var getAllMaintenence: [MaintenanceLog] {
        return vehicle?.maintenanceLogs!.allObjects as! [MaintenanceLog]
    }
}
struct MaintenanceLogDetailView: View {
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \MaintenanceLog.title, ascending: false)],
        animation: .default)
    
    private var logs: FetchedResults<MaintenanceLog>
    
    var body: some View {
        ScrollView {
            ForEach(logs) { log in
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


