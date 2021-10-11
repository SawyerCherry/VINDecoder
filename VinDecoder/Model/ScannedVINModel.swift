//
//  ScannedTextModel.swift
//  VinDecoder
//
//  Created by Sawyer Cherry on 9/29/21.
//

import Foundation

class TextItem: Identifiable {
    var id: String = UUID().uuidString
    var vin: String = ""
    
}


class RecognizedContent: ObservableObject {
    @Published var items = [TextItem]()
}

