//
//  Created by Andrei on 02/11/2022.
//

protocol LandmarkDetailsProviderProtocol {
    func getLandmarkDetails(by id: Int, completion: @escaping (LandmarkDetailsModel?) -> Void)
}

struct LandmarkDetailsProvider: LandmarkDetailsProviderProtocol {
    
    let dataStore: LandmarksDataStore = .shared

    func getLandmarkDetails(by id: Int, completion: @escaping (LandmarkDetailsModel?) -> Void) {
        let landmark = dataStore.models?.first { $0.id == id }
        completion(landmark)
    }
    
}
