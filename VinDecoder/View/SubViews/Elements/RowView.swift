//
//  RowView.swift
//  VinDecoder
//
//  Created by Sawyer Cherry on 10/13/21.
//

import SwiftUI

struct RowView: View {
    var body: some View {
        HStack {
            Image("VINDY")
                
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80, alignment: .center)
                .shadow(color: Color(red: 0, green: 0, blue: 0.3), radius: 3, x: 2, y: 2)
                .padding(5)
                .background(LinearGradient(gradient: Gradient(colors: [Color("indigo")]), startPoint: .top, endPoint: .bottom))
                .cornerRadius(8)
            VStack(alignment: .leading, spacing: 5, content: {
                Text("VINDY")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("VINDY is a Vehicle Identification Number decoder. Scan your VIN directly from the vehicle or a piece of paper.")
                    .font(.caption)
                    .foregroundColor(Color.secondary)
                
            })
        }//: HSTACK
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView()
    }
}
