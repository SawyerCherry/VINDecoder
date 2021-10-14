//
//  DataRowView.swift
//  VinDecoder
//
//  Created by Sawyer Cherry on 10/13/21.
//

import SwiftUI

struct DataRowView: View {
    var title: String
    var data: String?
    var body: some View {
        VStack {
            Divider().padding(.vertical, 4)
            HStack {
                Text(title)
                    .foregroundColor(Color.gray)
                Spacer()
                
                Text(data!)
                    .foregroundColor(Color.black)
            }
        }
    }
}

struct DataRowView_Previews: PreviewProvider {
    static var previews: some View {
        DataRowView(title: "Dummy", data: "Data")
            .previewLayout(.fixed(width: 375, height: 60))
            .padding()
    }
}
