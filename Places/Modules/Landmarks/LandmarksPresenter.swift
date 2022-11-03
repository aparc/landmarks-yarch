//
//  Displaying list of Places
//  Created by Andrei on 01/11/2022.
//

import UIKit

protocol LandmarksPresentationLogic {
    func presentLandmarks(response: LandmarksDataFlow.FetchLandmarks.Response)
}

/// Responds for displaying data in module Landmarks
class LandmarksPresenter: LandmarksPresentationLogic {
    weak var viewController: LandmarksDisplayLogic?
    
    private let errorMessage = "Error loading data"
    
    // MARK: - Present Landmarks
    func presentLandmarks(response: LandmarksDataFlow.FetchLandmarks.Response) {
        var viewModel: LandmarksDataFlow.FetchLandmarks.ViewModel
        
        switch response.result {
        case .failure:
            viewModel = LandmarksDataFlow.FetchLandmarks.ViewModel(state: .error(message: errorMessage))
        case let .success(result):
            if result.isEmpty {
                viewModel = LandmarksDataFlow.FetchLandmarks.ViewModel(state: .emptyResult)
            } else {
                let data = result.map {
                    LandmarksViewModel(
                        id: $0.id,
                        name: $0.name,
                        imageName: $0.imageName,
                        isFavorite: $0.isFavorite
                    )
                }
                viewModel = LandmarksDataFlow.FetchLandmarks.ViewModel(state: .result(data))
            }
        }
        
        viewController?.displayItems(viewModel: viewModel)
    }
}
