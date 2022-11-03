//
//  Present landmark details
//  Created by Andrei on 02/11/2022.
//

enum LandmarkDetailsDataFlow {
    // MARK: Use cases
    enum FetchLandmarkDetails {
        struct Request {
            let id: Int
        }

        struct Response {
            var result: LandmarkDetailsRequestResult
        }

        struct ViewModel {
            var state: ViewControllerState
        }
    }

    enum LandmarkDetailsRequestResult {
        case failure(LandmarkDetailsError)
        case success(LandmarkDetailsModel)
    }

    enum ViewControllerState {
        case initial(landmarkId: Int)
        case loading
        case result(LandmarkDetailsViewModel)
        case error(message: String)
    }

    enum LandmarkDetailsError: Error {
        case fetchError(message: String)
    }
}
