//
//  Created by Andrei on 01/11/2022.
//

import CoreLocation

struct LandmarkModel: Identifiable, Hashable, Codable {
    
    let id: Int
    let name: String
    let city: String
    let state: String
    let park: String
    let imageName: String
    let coordinates: Coordinates
    let isFavorite: Bool
    
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }
    
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
    
}

extension LandmarkModel: Equatable {
    static func == (lhs: LandmarkModel, rhs: LandmarkModel) -> Bool {
        return lhs.id == rhs.id
    }
}
