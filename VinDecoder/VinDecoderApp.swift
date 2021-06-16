//
//  VinDecoderApp.swift
//  VinDecoder
//
//  Created by Sawyer Cherry on 3/15/21.
//

import SwiftUI

@main
struct VinDecoderApp: App {
    var body: some Scene {
        WindowGroup {
            // This tab view displays A way of navigation fot the user, by making a tab bar at the bottom of the screen
            TabView {
                ContentView()
                    .tabItem {
                        Image(systemName: "car")
                        Text("VIN Decoder")
                    }.tag(0)
                    
                    
                  
                DiagnosticView()
                    .tabItem {
                        Image(systemName: "wrench.and.screwdriver")
                        Text("DTC Decoder")
                    }.tag(1)
                
            }
        }
    }
}
