//
//  SUT: LandmarkDetailsViewController
//
//  Collaborators:
//  LandmarkDetailsInteractor
//

import Quick
import Nimble

@testable import Landmarks

class LandmarkDetailsViewControllerTests: QuickSpec {
    override func spec() {
        var viewController: LandmarkDetailsViewController!
        var interactorMock: LandmarkDetailsInteractorMock!

        beforeEach {
            interactorMock = LandmarkDetailsInteractorMock()
            viewController = LandmarkDetailsViewController(interactor: interactorMock)
        }

        describe(".fetchLandmarkDetails") {
            it("should call method in interactor") {
                // when
                await viewController.fetchLandmarkDetails(landmarkId: 1)

                // then
                await expect(interactorMock.doSomethingWasCalled).to(equal(1))
                await expect(interactorMock.doSomethingArguments).toNot(beNil())
            }
        }
    }
}

extension LandmarkDetailsViewControllerTests {
    enum TestData {
        static let request = LandmarkDetailsDataFlow.FetchLandmarkDetails.Request(id: 1)
    }
}

fileprivate class LandmarkDetailsInteractorMock: LandmarkDetailsBusinessLogic {
    var doSomethingWasCalled: Int = 0
    var doSomethingArguments: LandmarkDetailsDataFlow.FetchLandmarkDetails.Request?

    func getLandmarkDetails(request: LandmarkDetailsDataFlow.FetchLandmarkDetails.Request) {
        doSomethingWasCalled += 1
        doSomethingArguments = request
    }
}
