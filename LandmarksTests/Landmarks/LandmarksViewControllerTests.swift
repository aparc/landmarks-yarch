//
//  SUT: PlacesViewController
//
//  Collaborators:
//  PlacesInteractor
//

import Quick
import Nimble

@testable import Landmarks

class LandmarksViewControllerTests: QuickSpec {
    override func spec() {
        var viewController: LandmarksViewController!
        var interactorMock: LandmarksInteractorMock!
        
        beforeEach {
            interactorMock = LandmarksInteractorMock()
            viewController = LandmarksViewController(interactor: interactorMock)
        }
        
        describe(".fetchItems") {
            it("should call method in interactor") {
                // when
                viewController.fetchItems()
                
                // then
                expect(interactorMock.doSomethingWasCalled).to(equal(1))
                expect(interactorMock.doSomethingArguments).toNot(beNil())
            }
        }
    }
}

extension LandmarksViewControllerTests {
    enum TestData {
        static let request = LandmarksDataFlow.FetchLandmarks.Request()
    }
}

fileprivate class LandmarksInteractorMock: LandmarksBusinessLogic {
    var doSomethingWasCalled: Int = 0
    var doSomethingArguments: LandmarksDataFlow.FetchLandmarks.Request?
    
    func fetchLandmarks(request: LandmarksDataFlow.FetchLandmarks.Request) {
        doSomethingWasCalled += 1
        doSomethingArguments = request
    }
}
