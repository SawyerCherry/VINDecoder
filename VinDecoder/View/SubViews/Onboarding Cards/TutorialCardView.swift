//
//  TutorialCardView.swift
//  VinDecoder
//
//  Created by Sawyer Cherry on 10/12/21.
//

import SwiftUI

struct TutorialCardView: View {
    @State private var isAnimating: Bool = false
    var body: some View {
        
        ZStack {
            VStack(spacing: 20) {
                HStack(alignment: .center) {
                    Image("VINDY")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100, alignment: .topLeading)
                    Spacer()
                    Text("Tutorial")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 30, weight: .semibold, design: .rounded))
                        .frame(alignment: .center)
                        .padding(.trailing, 15)
                        .padding(.leading, 15)
                        .foregroundColor(.black)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 200, alignment: .topLeading)
    
                
                Group {
                    HStack(alignment: .center) {
                        Image(systemName: "hand.tap")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                        Text("The Scan VIN Button in the top left will scan your VIN from your camera")
                            .font(.body)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal)
                    
                    HStack(alignment: .center) {
                        Image(systemName: "text.viewfinder")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                        Text("After the VIN is Scanned, crop the Image by positioning the frame around your VIN")
                            .font(.body)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            
                    }
                    .padding(.horizontal)
                    
                    HStack(alignment: .center) {
                        Image(systemName: "square.and.arrow.down")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                        Text("After the VIN is cropped, Tap save and the VIN will export to the Decoder.")
                            .font(.body)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            
                    }
                    .padding(.horizontal)
                    
                    HStack(alignment: .center) {
                        Image(systemName: "doc.text")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                        Text("After Exporting to the Decoder, our backend will validate the VIN and display your data for that Scanned VIN.")
                            .font(.body)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal)
                    
                    HStack(alignment: .center) {
                        Image(systemName: "rectangle.and.pencil.and.ellipsis")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                        Text("If you entered the VIN manually, select Fetch Data to decode the VIN")
                            .font(.body)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }

                
                
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
                .padding()

        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                isAnimating = true
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        
        .background(LinearGradient(gradient: Gradient(colors: [Color("baby"), Color("honolulu")]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(20)
        .padding(.top)
        .padding(.horizontal)
    }
}

struct TutorialCardView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialCardView()
    }
}
