//
//  MaintenanceLogDetailView.swift
//  VinDecoder
//
//  Created by Sawyer Cherry on 1/12/22.
//

import SwiftUI

extension MaintenanceLog {
    var getAllMaintenence: [MaintenanceLog] {
        return vehicle!.allObjects as! [Livestock]
    }
}
struct MaintenanceLogDetailView: View {
    @ObservedObject var log: MaintenanceLog
    var body: some View {
        ScrollView {
            ForEach(log) { log in
                GroupBox(label: HeaderView(labelText: "Maintenence Log", labelImage: "wrench.and.screwdriver")) {
                    HStack {
                        
                    }//:Stack
                }.padding()
            }//:Loop
        }.navigationTitle("Maintenance Logs")
    }
}


