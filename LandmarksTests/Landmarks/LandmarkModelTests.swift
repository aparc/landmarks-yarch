//
//  SUT: PlacesModel
//

import Quick
import Nimble

@testable import Landmarks

class LandmarkModelTests: QuickSpec {
    override func spec() {
        describe("equalit operator") {
            it("should return true for same objects"){
                expect(TestData.model == TestData.model).to(beTrue())
            }

            it("should return false for objects with different uid"){
                expect(TestData.model == TestData.differentUidModel).to(beFalse())
            }

            it("should ignore name attribute for equality"){
                expect(TestData.model == TestData.differentNameModel).to(beTrue())
            }
        }
    }
}

extension LandmarkModelTests {
    enum TestData {
        static let model = LandmarkModel(id: 1, name: "name", city: "city", state: "state", park: "park", imageName: "image", coordinates: .init(latitude: 121.12, longitude: 121.12), isFavorite: true)
        static let differentUidModel = LandmarkModel(id: 2, name: "name", city: "city", state: "state", park: "park", imageName: "image", coordinates: .init(latitude: 121.12, longitude: 121.12), isFavorite: true)
        static let differentNameModel = LandmarkModel(id: 1, name: "name2", city: "city", state: "state", park: "park", imageName: "image", coordinates: .init(latitude: 121.12, longitude: 121.12), isFavorite: true)

        static let defaultEntitiesCollectionCount = 1
        static func entitiesCollection(withCount count: Int = defaultEntitiesCollectionCount) -> [LandmarkModel] {
            var collection: [LandmarkModel] = []
            while collection.count < count {
                collection.append(LandmarkModel(id: 4, name: "qwe", city: "qwe", state: "qwe", park: "qwe", imageName: "qwe", coordinates: .init(latitude: 123.42, longitude: 435.34), isFavorite: true))
            }
            return collection
        }
    }
}
