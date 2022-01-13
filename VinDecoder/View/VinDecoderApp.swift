//
//  VinDecoderApp.swift
//  VinDecoder
//
//  Created by Sawyer Cherry on 3/15/21.
//

import SwiftUI

@main
struct VinDecoderApp: App {
    
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            if isOnboarding{
                OnboardingView()
            } else {
                TabView {
                    ContentView()
                        .tabItem {
                            Image(systemName: "touchid")
                                .foregroundColor(Color(UIColor.systemGreen))
                            Text("VIN Decoder")
                                .foregroundColor(Color(UIColor.systemGreen))
                        }
                    
                    DiagnosticView()
                        .tabItem {
                            Image(systemName: "wrench.and.screwdriver")
                                .foregroundColor(Color(UIColor.systemGreen))
                            Text("DTC Decoder")
                                .foregroundColor(Color(UIColor.systemGreen))
                        }
                    
                    
                    CreateView()
                        .tabItem {
                            Image(systemName: "car.2.fill")
                                .foregroundColor(Color("honolulu"))
                            Text("My Vehicles")
                                .foregroundColor(Color("honolulu"))
                        }
                 
                    
                    InfoView()
                        .tabItem {
                            Image(systemName: "info.circle")
                                .foregroundColor(Color(UIColor.systemGreen))
                            Text("Information")
                                .foregroundColor(Color(UIColor.systemGreen))
                        }
                }
                
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}



import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CoreDataModel")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    func addVehicle(name: String, year: String, make: String, model: String, engine: String, titleStatus: String, vin: String, driveType: String, transmission: String, trim: String, color: String) {
        withAnimation {
            let newVehicle = Vehicle(context: container.viewContext)
            
            newVehicle.name = name
            newVehicle.make = make
            newVehicle.driveType = driveType
            newVehicle.model = model
            newVehicle.year = year
            newVehicle.engine = engine
            newVehicle.trim = trim
            newVehicle.transmission = transmission
            newVehicle.titleStatus = titleStatus
            newVehicle.vin = vin
            newVehicle.color = color
            save()
        }
    }
    
    
    func addMaintenanceLog(cost: Double, date: String, notes: String, title: String, into vehicle: Vehicle) {
        withAnimation {
            let newLog = MaintenanceLog(context: container.viewContext)
            newLog.cost = cost
            newLog.date = date
            newLog.title = title
            newLog.notes = notes
            vehicle.addToMaintenanceLogs(newLog)
            save()
        }
    }
    
    func findVehicles() -> Vehicle? {
        let fetch = Vehicle.fetchRequest()
        fetch.sortDescriptors = [NSSortDescriptor(keyPath: \Vehicle.name, ascending: false)]
        fetch.fetchLimit = 1
        guard let result = try? container.viewContext.fetch(fetch).first else {
            return nil
        }
        return result
    }
    
    func numberofVehicles() -> Int {
        let fetch = Vehicle.fetchRequest()
        return (try? container.viewContext.fetch(fetch).count) ?? 0
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
