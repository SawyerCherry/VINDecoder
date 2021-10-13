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
    
    var body: some Scene {
        WindowGroup {
            // This tab view displays A way of navigation fot the user, by making a tab bar at the bottom of the screen
            
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
                    
                    InfoView()
                        .tabItem {
                            Image(systemName: "info.circle")
                                .foregroundColor(Color(UIColor.systemGreen))
                            Text("Information")
                                .foregroundColor(Color(UIColor.systemGreen))
                        }.tag(2)

                }
            }
        }
    }
}
