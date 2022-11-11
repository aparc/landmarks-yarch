//
//  SUT: LandmarkDetailsBuilder
//
//  Collaborators:
//  LandmarkDetailsViewController
//  LandmarkDetailsInteractor
//  LandmarkDetailsPresenter
//  LandmarkDetailsProvider
//

import Quick
import Nimble

@testable import Landmarks

class LandmarkDetailsBuilderTests: QuickSpec {
    override func spec() {
        var builder: LandmarkDetailsBuilder!
        
        beforeEach {
            builder = LandmarkDetailsBuilder()
        }
        
        describe(".build") {
            it("should build module parts") {
                // when
                let controller = builder.set(initialState: TestData.initialState).build() as? LandmarkDetailsViewController
                let interactor =   controller?.interactor as? LandmarkDetailsInteractor
                let presenter = interactor?.presenter as? LandmarkDetailsPresenter
                
                // then
                expect(controller).toNot(beNil())
                expect(interactor).toNot(beNil())
                expect(presenter).toNot(beNil())
            }
            
            it("should set dependencies between module parts") {
                // when
                let controller = builder.set(initialState: TestData.initialState).build() as? LandmarkDetailsViewController
                let interactor =   controller?.interactor as? LandmarkDetailsInteractor
                let presenter = interactor?.presenter as? LandmarkDetailsPresenter
                
                // then
                expect(presenter?.viewController).to(beIdenticalTo(controller))
            }
        }
    }
}

extension LandmarkDetailsBuilderTests {
    enum TestData {
        static let initialState = LandmarkDetailsDataFlow.ViewControllerState.loading
    }
}
