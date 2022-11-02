//
//  SUT: PlacesViewController
//
//  Collaborators:
//  PlacesInteractor
//

import Quick
import Nimble

@testable import Places

class PlacesViewControllerTests: QuickSpec {
    override func spec() {
        var viewController: LandmarksViewController!
        var interactorMock: PlacesInteractorMock!

        beforeEach {
            interactorMock = PlacesInteractorMock()
            viewController = LandmarksViewController(interactor: interactorMock)
        }

        describe(".doSomething") {
            it("should call method in interactor") {
                // when
                viewController.doSomething()

                // then
                expect(interactorMock.doSomethingWasCalled).to(equal(1))
                expect(interactorMock.doSomethingArguments).toNot(beNil())
            }
        }
    }
}

extension PlacesViewControllerTests {
    enum TestData {
        static let request = Landmarks.FetchLandmarks.Request()
    }
}

fileprivate class PlacesInteractorMock: LandmarksBusinessLogic {
    var doSomethingWasCalled: Int = 0
    var doSomethingArguments: Landmarks.FetchLandmarks.Request?

    func fetchLandmarks(request: Landmarks.FetchLandmarks.Request) {
        doSomethingWasCalled += 1
        doSomethingArguments = request
    }
}
