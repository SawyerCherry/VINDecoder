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
                            Image(systemName: "car")
                                .foregroundColor(Color(UIColor.systemGreen))
                            Text("VIN Decoder")
                                .foregroundColor(Color(UIColor.systemGreen))
                        }.tag(0)
                    
                    DiagnosticView()
                        .tabItem {
                            Image(systemName: "wrench.and.screwdriver")
                                .foregroundColor(Color(UIColor.systemGreen))
                            Text("DTC Decoder")
                                .foregroundColor(Color(UIColor.systemGreen))
                        }.tag(1)
                    
                    
                    CreateView()
                        .tabItem {
                            Image(systemName: "tray.full.fill")
                                .foregroundColor(Color("honolulu"))
                            Text("My Data")
                                .foregroundColor(Color("honolulu"))
                        }.tag(2)
                    
                    InfoView()
                        .tabItem {
                            Image(systemName: "info.circle")
                                .foregroundColor(Color(UIColor.systemGreen))
                            Text("Information")
                                .foregroundColor(Color(UIColor.systemGreen))
                        }.tag(3)
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
    
    func addVehicle(name: String, year: Int, make: String, model: String, engine: String, titleStatus: String, vin: String, driveType: String, transmission: String, trim: String) {
        withAnimation {
            let newVehicle = Vehicle(context: container.viewContext)
            
            newVehicle.name = name
            newVehicle.make = make
            newVehicle.driveType = driveType
            newVehicle.model = model
            newVehicle.year = Int16(year)
            newVehicle.engine = engine
            newVehicle.trim = trim
            newVehicle.transmission = transmission
            newVehicle.titleStatus = titleStatus
            newVehicle.vin = vin
            
            save()
        }
        
    }
    
    
    func addVIN(nickName: String, vin: String) {
        withAnimation {
            let newVIN = VIN(context: container.viewContext)
            
            newVIN.nickName = nickName
            newVIN.vin = vin
            
            save()
        }
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
