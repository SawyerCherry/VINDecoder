//
//  DiagnosticData.swift
//  VinDecoder
//
//  Created by Sawyer Cherry on 3/18/21.
//

import Foundation


struct DiagnosticData: Decodable {
    var dtc_data: DTCData
}

// these are the two things that we will be recieving from the API.
struct DTCData: Decodable {
    var system: String
    var fault: String
}



