//
//  VehicleData.swift
//  VinDecoder
//
//  Created by Sawyer Cherry on 3/15/21.
//

import Foundation


struct VehicleData: Decodable {
    var vinData: VINData
    var specData: SpecificationData
}

struct VINData: Decodable {
    var vin: String
}

struct SpecificationData: Decodable {
    var make: String
}
