//
//  SUT: PlacesPresenter
//
//  Collaborators:
//  PlacesViewController
//

import Quick
import Nimble

@testable import Landmarks

class LandmarksPresenterTests: QuickSpec {
    override func spec() {
        var presenter: LandmarksPresenter!
        var viewControllerMock: PlacesViewControllerMock!

        beforeEach {
            presenter = LandmarksPresenter()
            viewControllerMock = PlacesViewControllerMock()
            presenter.viewController = viewControllerMock
        }

        describe(".presentSomething") {
            context("successfull empty result") {
                it ("should prepare empty view model and display it in view") {
                    // when
                    presenter.presentLandmarks(response: TestData.successEmptyResponse)
                    // then
                    await expect(viewControllerMock.displaySomethingWasCalled).to(beTruthy())
                    expect{ if case .emptyResult? = viewControllerMock.displaySomethingArguments?.state { return true }; return false }.to(beTrue())
                }
            }

            context("successfull result") {
                it ("should prepare result view model and display it in view") {
                    // when
                    presenter.presentLandmarks(response: TestData.successResponse)
                    // then
                    await expect(viewControllerMock.displaySomethingWasCalled).to(beTruthy())
                    expect{ if case .result(_)? = viewControllerMock.displaySomethingArguments?.state { return true }; return false }.to(beTrue())
                }
            }

            context("failure result") {
                it ("should prepare error view model and display it in view") {
                    // when
                    presenter.presentLandmarks(response: TestData.failureResponse)
                    // then
                    await expect(viewControllerMock.displaySomethingWasCalled).to(beTruthy())
                    expect{ if case .error(_)? = viewControllerMock.displaySomethingArguments?.state { return true }; return false }.to(beTrue())
                }
            }
        }
    }
}

extension LandmarksPresenterTests {
    enum TestData {
        static let successEmptyResponse = LandmarksDataFlow.FetchLandmarks.Response(result: .success([]))
        static let successResponse = LandmarksDataFlow.FetchLandmarks.Response(result: .success([LandmarkModel(id: 1, name: "", city: "", state: "", park: "", imageName: "", coordinates: .init(latitude: 213.12, longitude: 421.12), isFavorite: false)]))
        static let failureResponse = LandmarksDataFlow.FetchLandmarks.Response(result: .failure(.fetchError(message: "some error")))
    }
}

fileprivate class PlacesViewControllerMock: LandmarksDisplayLogic {
    var displaySomethingWasCalled: Int = 0
    var displaySomethingArguments: LandmarksDataFlow.FetchLandmarks.ViewModel?

    func displayItems(viewModel: LandmarksDataFlow.FetchLandmarks.ViewModel) {
        displaySomethingWasCalled += 1
        displaySomethingArguments = viewModel
    }
}
