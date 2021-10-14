//
//  HeaderView.swift
//  VinDecoder
//
//  Created by Sawyer Cherry on 10/13/21.
//

import SwiftUI

struct HeaderView: View {
    
    //: MARK: - Properties
    
    var labelText: String
    var labelImage: String
    
    
    var body: some View {
        HStack {
            Text(labelText.uppercased())
            Spacer()
            Image(systemName: labelImage)
        }
    }
}


