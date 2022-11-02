//
//  Displaying list of Places
//  Created by Andrei on 01/11/2022.
//

import UIKit

class LandmarksBuilder: ModuleBuilder {

    func build() -> UIViewController {
        let presenter = LandmarksPresenter()
        let interactor = LandmarksInteractor(presenter: presenter)
        let controller = LandmarksViewController(interactor: interactor)

        presenter.viewController = controller
        return controller
    }
}
