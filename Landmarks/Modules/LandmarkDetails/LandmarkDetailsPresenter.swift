//
//  Present landmark details
//  Created by Andrei on 02/11/2022.
//

import UIKit

protocol LandmarkDetailsPresentationLogic {
    func presentLandmarkDetails(response: LandmarkDetailsDataFlow.FetchLandmarkDetails.Response)
}

class LandmarkDetailsPresenter: LandmarkDetailsPresentationLogic {
    weak var viewController: LandmarkDetailsDisplayLogic?

    // MARK: - Present Landmark Details
    func presentLandmarkDetails(response: LandmarkDetailsDataFlow.FetchLandmarkDetails.Response) {
        var viewModel: LandmarkDetailsDataFlow.FetchLandmarkDetails.ViewModel
        
        switch response.result {
        case let .failure(error):
            viewModel = LandmarkDetailsDataFlow.FetchLandmarkDetails.ViewModel(state: .error(message: error.localizedDescription))
        case let .success(result):
            let landmarkDetailsViewModel = LandmarkDetailsViewModel(
                id: result.id,
                name: result.name,
                park: result.park,
                state: result.state,
                imageName: result.imageName,
                locationCoordinate: result.locationCoordinate,
                isFavorite: result.isFavorite
            )
            viewModel = LandmarkDetailsDataFlow.FetchLandmarkDetails.ViewModel(state: .result(landmarkDetailsViewModel))
        }
        
        viewController?.displayDetails(viewModel: viewModel)
    }
}
