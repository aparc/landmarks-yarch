//
//  SUT: PlacesProvider
//
//  Collaborators:
//  PlacesService
//  PlacesDataStore
//

import Quick
import Nimble

@testable import Places

class PlacesProviderTests: QuickSpec {
    override func spec() {
        var provider: LandmarksProvider!
        var serviceMock: PlacesServiceMock!
        var dataStoreMock: PlacesDataStoreMock!

        var getItemsResult: (items: [LandmarkModel]?, error: LandmarksProviderError?)

        beforeEach {
            serviceMock = PlacesServiceMock()
            dataStoreMock = PlacesDataStoreMock()
            provider = LandmarksProvider(dataStore: dataStoreMock, service: serviceMock)

            getItemsResult = (nil, nil)
        }

        describe(".getItems") {
            context("cache is empty") {
                beforeEach {
                    dataStoreMock.models = nil
                }

                it ("should request data from service") {
                    // when
                    provider.fetchItems { (_, _) in }
                    // then
                    expect(serviceMock.fetchItemsWasCalled).to(equal(1))
                }

                context("successfull response"){
                    it("should save data to store"){
                        // given
                        serviceMock.fetchItemsCompletionStub = (TestData.responseData, nil)
                        // when
                        provider.fetchItems { (_, _) in }
                        // then
                        expect(dataStoreMock.models).to(equal(TestData.responseData))
                    }

                    it("should return result in callback"){
                        // given
                        serviceMock.fetchItemsCompletionStub = (TestData.responseData, nil)
                        // when
                        provider.fetchItems { getItemsResult = ($0, $1) }
                        // then
                        expect(getItemsResult.items).to(equal(TestData.responseData))
                        expect(getItemsResult.error).to(beNil())
                    }
                }

                context("failed response"){
                    it("should not update store"){
                        // given
                        serviceMock.fetchItemsCompletionStub = (nil, TestData.responseError)
                        // when
                        provider.fetchItems { (_, _) in }
                        // then
                        expect(dataStoreMock.models).to(beNil())
                    }

                    it("should return error in callback"){
                        // given
                        serviceMock.fetchItemsCompletionStub = (nil, TestData.responseError)
                        // when
                        provider.fetchItems { getItemsResult = ($0, $1) }
                        // then
                        expect(getItemsResult.items).to(beNil())
                        expect{ if case .getItemsFailed(_)? = getItemsResult.error { return true }; return false }.to(beTrue())
                    }
                }
            }
        }

        context("cache fulfilled"){
            it("should not call service"){
                // given
                dataStoreMock.models = TestData.responseData
                // when
                provider.fetchItems { (_, _) in }
                // then
                expect(serviceMock.fetchItemsWasCalled).to(equal(0))
            }

            it("should return data in callback"){
                // given
                dataStoreMock.models = TestData.responseData
                // when
                provider.fetchItems { getItemsResult = ($0, $1) }
                // then
                expect(getItemsResult.items).to(equal(TestData.responseData))
                expect(getItemsResult.error).to(beNil())
            }
        }
    }
}

extension PlacesProviderTests {
    enum TestData {
        static let responseData = PlacesModelTests.TestData.entitiesCollection()
        static let responseError = APIClientError.other
    }
}

fileprivate class PlacesServiceMock: LandmarksServiceProtocol {
    var fetchItemsWasCalled: Int = 0
    var fetchItemsArguments: (([LandmarkModel]?, APIClientError?) -> Void)?
    var fetchItemsCompletionStub: (result: [LandmarkModel]?, error: APIClientError?)

    func fetchItems(completion: @escaping ([LandmarkModel]?, Error?) -> Void) {
        fetchItemsWasCalled += 1
        fetchItemsArguments = completion
        completion(fetchItemsCompletionStub.result, fetchItemsCompletionStub.error)
    }
}

fileprivate class PlacesDataStoreMock: LandmarksDataStore {

}

fileprivate class ErrorMock: Error {}

enum APIClientError: Error {
    case other
}
