//
//  Created by Andrei on 01/11/2022.
//

protocol LandmarksServiceProtocol {
    func fetchItems(completion: @escaping ([LandmarkModel]?, Error?) -> Void)
}

class LandmarksService: LandmarksServiceProtocol {
    
    func fetchItems(completion: @escaping ([LandmarkModel]?, Error?) -> Void) {
        DataProvider.shared.load(Array<LandmarkModel>.self, "landmarkData.json") { result in
            switch result {
            case .success(let data): completion(data, nil)
            case .failure(let error): completion(nil, error)
            }
        }
    }
    
}
