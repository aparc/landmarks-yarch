//
//  SUT: LandmarkDetailsInteractor
//
//  Collaborators:
//  LandmarkDetailsProvider
//  LandmarkDetailsPresenter
//

import Quick
import Nimble

@testable import Landmarks

class LandmarkDetailsInteractorTests: QuickSpec {
    override func spec() {
        var interactor: LandmarkDetailsInteractor!
        var presenterMock: LandmarkDetailsPresenterMock!
        var providerMock: LandmarkDetailsProviderMock!

        beforeEach {
            providerMock = LandmarkDetailsProviderMock()
            presenterMock = LandmarkDetailsPresenterMock()
            interactor = LandmarkDetailsInteractor(presenter: presenterMock, provider: providerMock)
        }

        describe(".getLandmarkDetails") {
            it("should get data from provider") {
                // when
                interactor.getLandmarkDetails(request: TestData.request)
                // then
                await expect(providerMock.getItemsWasCalled).to(equal(1))
            }

            context("getItems successfull"){
                it("should prepare success response and call presenter"){
                    // given
                    providerMock.getItemsCompletionStub = (TestData.model)
                    // when
                    interactor.getLandmarkDetails(request: TestData.request)
                    // then
                    await expect(presenterMock.presentSomethingWasCalled).to(equal(1))
                    await expect(presenterMock.presentSomethingArguments).toNot(beNil())
                    expect { if case .success(_)? = presenterMock.presentSomethingArguments?.result { return true }; return false }.to(beTrue())
                }
            }

            context("getItems failed"){
                it("should prepare failed response and call presenter"){
                    // given
                    providerMock.getItemsCompletionStub = (nil)
                    // when
                    interactor.getLandmarkDetails(request: TestData.request)
                    // then
                    await expect(presenterMock.presentSomethingWasCalled).to(equal(1))
                    await expect(presenterMock.presentSomethingArguments).toNot(beNil())
                    expect{ if case .failure(_)? = presenterMock.presentSomethingArguments?.result { return true }; return false }.to(beTrue())
                }
            }
        }
    }
}

extension LandmarkDetailsInteractorTests {
    enum TestData {
        static let request = LandmarkDetailsDataFlow.FetchLandmarkDetails.Request(id: 1)
        static let model = LandmarkDetailsModelTests.TestData.model

        fileprivate static let underlyingError = ErrorMock()
    }
}

fileprivate class LandmarkDetailsProviderMock: LandmarkDetailsProviderProtocol {
    func getLandmarkDetails(by id: Int, completion: @escaping (LandmarkDetailsModel?) -> Void) {
        getItemsWasCalled += 1
        getItemsArguments = completion
        completion(getItemsCompletionStub)
    }
    
    var getItemsWasCalled: Int = 0
    var getItemsArguments: ((LandmarkDetailsModel?) -> Void)?
    var getItemsCompletionStub: (LandmarkDetailsModel?) = (nil)

}

fileprivate class LandmarkDetailsPresenterMock: LandmarkDetailsPresentationLogic {
    var presentSomethingWasCalled: Int = 0
    var presentSomethingArguments: LandmarkDetailsDataFlow.FetchLandmarkDetails.Response?

    func presentLandmarkDetails(response: LandmarkDetailsDataFlow.FetchLandmarkDetails.Response) {
        presentSomethingWasCalled += 1
        presentSomethingArguments = response
    }
}

fileprivate class ErrorMock: Error { }
