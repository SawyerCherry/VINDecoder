//
//  ReadyCardView.swift
//  VinDecoder
//
//  Created by Sawyer Cherry on 10/12/21.
//

import SwiftUI

struct ReadyCardView: View {
    
    //: MARK: - Properties
    @State private var isAnimating: Bool = false
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 20) {
                Image("VINDY")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300, alignment: .center)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 1), radius: 2, x: 2, y: 2)
                
                Text("Ready to decode your VIN?")
                    .font(.title)
                
                Text("You can always return to these pages from the Info Tab in the App.")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                StartButtonView()
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                isAnimating = true
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        
        .background(LinearGradient(gradient: Gradient(colors: [Color("indigo"), Color("baby")]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(20)
        .padding(.top)
        .padding()
        
        
        
        
    }
}

struct ReadyCardView_Previews: PreviewProvider {
    static var previews: some View {
        ReadyCardView()
    }
}
