//
//  Displaying list of Places
//  Created by Andrei on 01/11/2022.
//

protocol LandmarksBusinessLogic {
    func fetchLandmarks(request: LandmarksDataFlow.FetchLandmarks.Request)
}

class LandmarksInteractor: LandmarksBusinessLogic {
    let presenter: LandmarksPresentationLogic
    let provider: LandmarksProviderProtocol

    init(presenter: LandmarksPresentationLogic, provider: LandmarksProviderProtocol = LandmarksProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    func fetchLandmarks(request: LandmarksDataFlow.FetchLandmarks.Request) {
        provider.fetchItems { (items, error) in
            let result: LandmarksDataFlow.LandmarksRequestResult
            if let items = items {
                let landmarks = request.onlyFavorites
                ? items.filter { $0.isFavorite }
                : items
                
                result = .success(landmarks)
            } else if let error = error {
                result = .failure(.someError(message: error.localizedDescription))
            } else {
                result = .failure(.someError(message: "No Data"))
            }
            self.presenter.presentLandmarks(response: LandmarksDataFlow.FetchLandmarks.Response(result: result))
        }
    }
}
