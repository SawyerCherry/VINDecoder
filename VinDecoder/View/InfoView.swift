//
//  InfoView.swift
//  VinDecoder
//
//  Created by Sawyer Cherry on 10/12/21.
//

import SwiftUI

struct InfoView: View {
    
    @AppStorage("isOnboarding") var isOnboarding: Bool = false
    
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 10) {
                    GroupBox(
                        label:
                            HeaderView(labelText: "About the App", labelImage: "info.circle")
                    ) {
                        Divider().padding(.vertical, 4)
                        
                        HStack(alignment: .center, spacing: 10) {
                            RowView()
                            
                            
                        }
                    }
                    .padding(.horizontal)
                    
                    
                    GroupBox(
                        label: HeaderView(labelText: "Restart Tutorial", labelImage: "restart.circle")
                    ) {
                        Divider().padding(.vertical, 4)
                        
                        Text("If you wish, you can restart the application by turning the switch to the on position. By doing this, it will restart the onboarding process and you will see the welcome screen once again.")
                            .padding(.vertical, 8)
                            .frame(minHeight: 60)
                            .layoutPriority(1)
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                        Toggle(isOn: $isOnboarding) {
                            if isOnboarding {
                                Text("Restarted".uppercased())
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("honolulu"))
                            } else {
                                Text("Restart".uppercased())
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.secondary)
                            }
                        }
                        .toggleStyle(SwitchToggleStyle(tint: Color("honolulu")))
                        .padding()
                        .background(Color(UIColor.tertiarySystemBackground).clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous)))
                        
                    }
                    .padding(.horizontal)
                    
                    
                }
                
            }.navigationTitle("Information")
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
            .preferredColorScheme(.dark)
    }
}
