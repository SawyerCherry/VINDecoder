//
//  InfoCardView.swift
//  VinDecoder
//
//  Created by Sawyer Cherry on 10/12/21.
//

import SwiftUI

struct InfoCardView: View {
    @State private var isAnimating: Bool = false
    var body: some View {
        ZStack {
            
            VStack(spacing: 10) {
                Text("What is a VIN?")
                    .font(.system(.largeTitle, design: .rounded))
                    .padding(.top)
                
                HStack(spacing: 10) {
                    Image(systemName: "info.circle")
                        .font(.system(size: 20))
                    Text("VIN: Vehicle Identification Number")
                }
                .padding(.horizontal)
                
                HStack(spacing: 10) {
                    Image(systemName: "car.2")
                        .font(.system(size: 20))
                    Text("Each and every VIN Number is unique")
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal)
                HStack(spacing: 10) {
                    Image(systemName: "touchid")
                        .font(.system(size: 20))
                    Text("Your vehicle's fingerprint")
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal)
                
                Divider()
                    .foregroundColor(.black)
                
                Text("Where can I find my VIN?")
                    .font(.system(.largeTitle, design: .rounded))
                    .padding(.top)
                    .multilineTextAlignment(.center)
                HStack(spacing: 10) {
                    Image(systemName: "doc.text.magnifyingglass")
                        .font(.system(size: 20))
                    Text("On your Vehicle's certificate of title")
                }
                .padding(.horizontal)
                HStack(spacing: 10) {
                    Image(systemName: "car")
                        .font(.system(size: 20))
                    Text("Lower left corner of the driver side dash")
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal)
                HStack(spacing: 10) {
                    Image(systemName: "car")
                        .font(.system(size: 20))
                    Text("Driver side door jamb")
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal)
                
                
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
            .foregroundColor(Color.black)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                isAnimating = true
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        
        .background(LinearGradient(gradient: Gradient(colors: [Color("indigo"), Color("honolulu")]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(20)
        .padding()
        
        
        
    }
}

struct InfoCardView_Previews: PreviewProvider {
    static var previews: some View {
        InfoCardView()
    }
}
