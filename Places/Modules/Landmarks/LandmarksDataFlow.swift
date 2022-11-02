//
//  Displaying list of Places
//  Created by Andrei on 01/11/2022.
//

enum Landmarks {
    
    // MARK: - Use cases
    enum FetchLandmarks {
        struct Request {
            var onlyFavorites: Bool = false
        }

        struct Response {
            var result: LandmarksRequestResult
        }

        struct ViewModel {
            var state: ViewControllerState
        }
    }

    enum LandmarksRequestResult {
        case failure(LandmarksError)
        case success([LandmarkModel])
    }

    enum ViewControllerState {
        case loading
        case result([LandmarksViewModel])
        case emptyResult
        case error(message: String)
    }

    enum LandmarksError: Error {
        case someError(message: String)
    }
}
