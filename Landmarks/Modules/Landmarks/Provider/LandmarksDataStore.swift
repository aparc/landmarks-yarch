//
//  Created by Andrei on 01/11/2022.
//


class LandmarksDataStore {
    
    static let shared = LandmarksDataStore()
    
    var models: [LandmarkModel]?
    
    private init() {}
}
