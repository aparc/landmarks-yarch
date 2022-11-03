//
//  Present landmark details
//  Created by Andrei on 02/11/2022.
//

import UIKit

class LandmarkDetailsBuilder: ModuleBuilder {

    var initialState: LandmarkDetailsDataFlow.ViewControllerState?

    func set(initialState: LandmarkDetailsDataFlow.ViewControllerState) -> LandmarkDetailsBuilder {
        self.initialState = initialState
        return self
    } 

    func build() -> UIViewController {
        let presenter = LandmarkDetailsPresenter()
        let interactor = LandmarkDetailsInteractor(presenter: presenter)
        let controller = LandmarkDetailsViewController(interactor: interactor, initialState: initialState ?? .loading)

        presenter.viewController = controller
        return controller
    }
}
