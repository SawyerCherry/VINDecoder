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
    @StateObject var model = CreateViewModel()
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Add Vehicle", destination: AddVehicleView())
                
                NavigationLink("Add Maintenance Log", destination: AddMaintenenceLogView())
                    .disabled(model.numberOfVehicles == 0)
                    
            }
            .navigationTitle("Add/View")
            
        }
        
        
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
