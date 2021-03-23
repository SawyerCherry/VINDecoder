//
//  DiagnosticData.swift
//  VinDecoder
//
//  Created by Sawyer Cherry on 3/18/21.
//

import Foundation


struct DiagnosticData: Decodable {
    
    var vin: String
    var dtc_data: DTCData
    
}

struct DTCData: Decodable {
    
    var system: String
    var fault: String
    
}


