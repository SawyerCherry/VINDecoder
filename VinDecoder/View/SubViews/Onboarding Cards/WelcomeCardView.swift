//
//  WelcomeView.swift
//  VinDecoder
//
//  Created by Sawyer Cherry on 10/12/21.
//

import SwiftUI

struct WelcomeCardView: View {
    @State private var isAnimating: Bool = false
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                //: IMAGE
                Image("VINDY")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300, alignment: .center)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 1), radius: 2, x: 2, y: 2)
                
                //: TITLE
                Text("A simple way to Decode VIN Numbers, and DTC Codes!")
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.black)
                    .font(.title2)
                    .scaleEffect(isAnimating ? 1.0 : 0.6)
                    .padding(.all)
            }
        }
        .onAppear {
            withAnimation(.easeIn(duration: 0.5)) {
                isAnimating = true
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        
        .background(LinearGradient(gradient: Gradient(colors: [Color("carolina"), Color("indigo")]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(20)
        .padding(.top)
        .padding(.horizontal)
    }
}

struct WelcomeCardView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeCardView()
    }
}
