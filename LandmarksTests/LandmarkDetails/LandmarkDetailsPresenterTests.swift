//
//  SUT: LandmarkDetailsPresenter
//
//  Collaborators:
//  LandmarkDetailsViewController
//

import Quick
import Nimble

@testable import Landmarks

class LandmarkDetailsPresenterTests: QuickSpec {
    override func spec() {
        var presenter: LandmarkDetailsPresenter!
        var viewControllerMock: LandmarkDetailsViewControllerMock!

        beforeEach {
            presenter = LandmarkDetailsPresenter()
            viewControllerMock = LandmarkDetailsViewControllerMock()
            presenter.viewController = viewControllerMock
        }

        describe(".presentSomething") {
            context("successfull result") {
                it ("should prepare result view model and display it in view") {
                    // when
                    presenter.presentLandmarkDetails(response: TestData.successResponse)
                    // then
                    await expect(viewControllerMock.displaySomethingWasCalled).to(beTruthy())
                    expect { if case .result(_)? = viewControllerMock.displaySomethingArguments?.state { return true }; return false }.to(beTrue())
                }
            }

            context("failure result") {
                it ("should prepare error view model and display it in view") {
                    // when
                    presenter.presentLandmarkDetails(response: TestData.failureResponse)
                    // then
                    await expect(viewControllerMock.displaySomethingWasCalled).to(beTruthy())
                    expect { if case .error(_)? = viewControllerMock.displaySomethingArguments?.state { return true }; return false }.to(beTrue())
                }
            }
        }
    }
}

extension LandmarkDetailsPresenterTests {
    enum TestData {
        static let successResponse = LandmarkDetailsDataFlow.FetchLandmarkDetails.Response(
            result: .success(
                LandmarkDetailsModel(
                    id: 1,
                    name: "name",
                    city: "city",
                    state: "state",
                    park: "park",
                    imageName: "image",
                    coordinates: .init(latitude: 1212.121, longitude: 212.12),
                    isFavorite: false
                )
            )
        )
        static let failureResponse = LandmarkDetailsDataFlow.FetchLandmarkDetails.Response(result: .failure(.someError(message: "some error")))
    }
}

fileprivate class LandmarkDetailsViewControllerMock: LandmarkDetailsDisplayLogic {
    var displaySomethingWasCalled: Int = 0
    var displaySomethingArguments: LandmarkDetailsDataFlow.FetchLandmarkDetails.ViewModel?

    func displayDetails(viewModel: LandmarkDetailsDataFlow.FetchLandmarkDetails.ViewModel) {
        displaySomethingWasCalled += 1
        displaySomethingArguments = viewModel
    }
}
