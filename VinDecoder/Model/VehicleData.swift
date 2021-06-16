import Foundation


struct VehicleData: Decodable {
    var vin: String
    var specification: SpecificationData
}

// This struct was created because this is the data that we will be grabbing from the API
struct SpecificationData: Decodable {
    var make: String
    var year: String
    var model: String
    var engine: String
    var trim_level: String
    var made_in: String
    var drive_type: String
    var fuel_type: String
    var overall_height: String
    var overall_length: String
    var overall_width: String
    var highway_mileage: String
    var city_mileage: String
    var transmission: String
    var style: String
    var anti_brake_system: String
    var optional_seating: String
}
