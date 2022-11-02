//
//  SUT: PlacesPresenter
//
//  Collaborators:
//  PlacesViewController
//

import Quick
import Nimble

@testable import Places

class PlacesPresenterTests: QuickSpec {
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
                    presenter.presentSomething(response: TestData.successEmptyResponse)
                    // then
                    expect(viewControllerMock.displaySomethingWasCalled).to(beTruthy())
                    expect{ if case .emptyResult? = viewControllerMock.displaySomethingArguments?.state { return true }; return false }.to(beTrue())
                }
            }

            context("successfull result") {
                it ("should prepare result view model and display it in view") {
                    // when
                    presenter.presentSomething(response: TestData.successResponse)
                    // then
                    expect(viewControllerMock.displaySomethingWasCalled).to(beTruthy())
                    expect{ if case .result(_)? = viewControllerMock.displaySomethingArguments?.state { return true }; return false }.to(beTrue())
                }
            }

            context("failure result") {
                it ("should prepare error view model and display it in view") {
                    // when
                    presenter.presentSomething(response: TestData.failureResponse)
                    // then
                    expect(viewControllerMock.displaySomethingWasCalled).to(beTruthy())
                    expect{ if case .error(_)? = viewControllerMock.displaySomethingArguments?.state { return true }; return false }.to(beTrue())
                }
            }
        }
    }
}

extension PlacesPresenterTests {
    enum TestData {
        static let successEmptyResponse = Landmarks.FetchLandmarks.Response(result: .success([]))
        static let successResponse = Landmarks.FetchLandmarks.Response(result: .success([LandmarkModel(uid: UUID().uuidString, name: "name")]))
        static let failureResponse = Landmarks.FetchLandmarks.Response(result: .failure(.someError(message: "some error")))
    }
}

fileprivate class PlacesViewControllerMock: LandmarksDisplayLogic {
    var displaySomethingWasCalled: Int = 0
    var displaySomethingArguments: Landmarks.FetchLandmarks.ViewModel?

    func displayItems(viewModel: Landmarks.FetchLandmarks.ViewModel) {
        displaySomethingWasCalled += 1
        displaySomethingArguments = viewModel
    }
}
