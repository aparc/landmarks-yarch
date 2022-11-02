//
//  Displaying list of Places
//  Created by Andrei on 01/11/2022.
//

import UIKit

protocol LandmarksPresentationLogic {
    func presentSomething(response: Landmarks.FetchLandmarks.Response)
}

/// Responds for displaying data in module Places
class LandmarksPresenter: LandmarksPresentationLogic {
    weak var viewController: LandmarksDisplayLogic?
    
    // MARK: Do something
    func presentSomething(response: Landmarks.FetchLandmarks.Response) {
        var viewModel: Landmarks.FetchLandmarks.ViewModel
        
        switch response.result {
        case let .failure(error):
            viewModel = Landmarks.FetchLandmarks.ViewModel(state: .error(message: error.localizedDescription))
        case let .success(result):
            if result.isEmpty {
                viewModel = Landmarks.FetchLandmarks.ViewModel(state: .emptyResult)
            } else {
                let data = result.map {
                    LandmarksViewModel(
                        id: $0.id,
                        name: $0.name,
                        imageName: $0.imageName,
                        isFavorite: $0.isFavorite
                    )
                }
                viewModel = Landmarks.FetchLandmarks.ViewModel(state: .result(data))
            }
        }
        
        viewController?.displayItems(viewModel: viewModel)
    }
}
