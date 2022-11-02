//
//  Created by Andrei on 01/11/2022.
//

protocol LandmarksProviderProtocol {
    func fetchItems(completion: @escaping ([LandmarkModel]?, LandmarksProviderError?) -> Void)
}

enum LandmarksProviderError: Error {
    case getItemsFailed(underlyingError: Error)
}

class LandmarksProvider: LandmarksProviderProtocol {
    let dataStore: LandmarksDataStore
    let service: LandmarksServiceProtocol

    init(dataStore: LandmarksDataStore = LandmarksDataStore(), service: LandmarksServiceProtocol = LandmarksService()) {
        self.dataStore = dataStore
        self.service = service
    }

    func fetchItems(completion: @escaping ([LandmarkModel]?, LandmarksProviderError?) -> Void) {
        if dataStore.models?.isEmpty == false {
            return completion(self.dataStore.models, nil)
        }
        service.fetchItems { (array, error) in
            if let error = error {
                completion(nil, .getItemsFailed(underlyingError: error))
            } else if let models = array {
                self.dataStore.models = models
                completion(self.dataStore.models, nil)
            }
        }
    }
}
