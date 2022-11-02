//
//  SUT: PlacesInteractor
//
//  Collaborators:
//  PlacesProvider
//  PlacesPresenter
//

import Quick
import Nimble

@testable import Places

class PlacesInteractorTests: QuickSpec {
    override func spec() {
        var interactor: LandmarksInteractor!
        var presenterMock: PlacesPresenterMock!
        var providerMock: PlacesProviderMock!
        
        beforeEach {
            providerMock = PlacesProviderMock()
            presenterMock = PlacesPresenterMock()
            interactor = LandmarksInteractor(presenter: presenterMock, provider: providerMock)
        }
        
        describe(".doSomething") {
            it("should get data from provider") {
                // when
                interactor.fetchLandmarks(request: TestData.request)
                // then
                await expect(providerMock.getItemsWasCalled).to(equal(1))
            }
            
            context("getItems successfull"){
                it("should prepare success response and call presenter"){
                    // given
                    providerMock.getItemsCompletionStub = (result: TestData.models, error: nil)
                    // when
                    interactor.fetchLandmarks(request: TestData.request)
                    // then
                    await expect(presenterMock.presentSomethingWasCalled).to(equal(1))
                    await expect(presenterMock.presentSomethingArguments).toNot(beNil())
                    expect{ if case .success(_)? = presenterMock.presentSomethingArguments?.result { return true }; return false }.to(beTrue())
                }
            }
            
            context("getItems failed"){
                it("should prepare failed response and call presenter"){
                    // given
                    providerMock.getItemsCompletionStub = (result: nil, error: TestData.getItemsFailedError)
                    // when
                    interactor.fetchLandmarks(request: TestData.request)
                    // then
                    await expect(presenterMock.presentSomethingWasCalled).to(equal(1))
                    await expect(presenterMock.presentSomethingArguments).toNot(beNil())
                    expect{ if case .failure(_)? = presenterMock.presentSomethingArguments?.result { return true }; return false }.to(beTrue())
                }
            }
        }
    }
}

extension PlacesInteractorTests {
    enum TestData {
        static let request = Landmarks.FetchLandmarks.Request()
        static let models = PlacesModelTests.TestData.entitiesCollection()
        
        fileprivate static let underlyingError = ErrorMock()
        fileprivate static let getItemsFailedError = LandmarksProviderError.getItemsFailed(underlyingError: underlyingError)
    }
}

fileprivate class PlacesProviderMock: LandmarksProviderProtocol {
    var getItemsWasCalled: Int = 0
    var getItemsArguments: (([LandmarkModel]?, LandmarksProviderError?) -> Void)?
    var getItemsCompletionStub: (result: [LandmarkModel]?, error: LandmarksProviderError?) = (nil, nil)
    
    func fetchItems(completion: @escaping ([LandmarkModel]?, LandmarksProviderError?) -> Void) {
        getItemsWasCalled += 1
        getItemsArguments = completion
        completion(getItemsCompletionStub.result, getItemsCompletionStub.error)
    }
}

fileprivate class PlacesPresenterMock: LandmarksPresentationLogic {
    var presentSomethingWasCalled: Int = 0
    var presentSomethingArguments: Landmarks.FetchLandmarks.Response?
    
    func presentSomething(response: Landmarks.FetchLandmarks.Response) {
        presentSomethingWasCalled += 1
        presentSomethingArguments = response
    }
}

fileprivate class ErrorMock: Error { }
