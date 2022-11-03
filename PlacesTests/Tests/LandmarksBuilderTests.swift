//
//  SUT: PlacesBuilder
//
//  Collaborators:
//  PlacesViewController
//  PlacesInteractor
//  PlacesPresenter
//  PlacesProvider
//

import Quick
import Nimble

@testable import Places

class LandmarksBuilderTests: QuickSpec {
    override func spec() {
        var builder: LandmarksBuilder!

        beforeEach {
            builder = LandmarksBuilder()
        }

        describe(".build") {
            it("should build module parts") {
                // when
                let controller = builder.build() as? LandmarksViewController
                let interactor = await controller?.interactor as? LandmarksInteractor
                let presenter = interactor?.presenter as? LandmarksPresenter

                // then
                await expect(controller).toNot(beNil())
                await expect(interactor).toNot(beNil())
                await expect(presenter).toNot(beNil())
            }

            it("should set dependencies between module parts") {
                // when
                let controller = builder.build() as? LandmarksViewController
                let interactor = await controller?.interactor as? LandmarksInteractor
                let presenter = interactor?.presenter as? LandmarksPresenter

                // then
                await expect(presenter?.viewController).to(beIdenticalTo(controller))
            }
        }
    }
}

extension LandmarksBuilderTests {
    enum TestData {
        static let initialState = LandmarksDataFlow.ViewControllerState.loading
    }
}
