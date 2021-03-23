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
        // 3C6UR5DL2GG106682
    }
}
