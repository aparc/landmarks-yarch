//
//  SUT: LandmarkDetailsModel
//

import Quick
import Nimble

@testable import Landmarks

class LandmarkDetailsModelTests: QuickSpec {
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

extension LandmarkDetailsModelTests {
    enum TestData {
        static let uid = UUID().uuidString
        static let name = "Name"
        static let model = LandmarkDetailsModel(id: 1, name: "name", city: "city", state: "state", park: "park", imageName: "image", coordinates: .init(latitude: 12.12, longitude: 32.12), isFavorite: false)
        static let differentUidModel = LandmarkDetailsModel(id: 2, name: "name", city: "city", state: "state", park: "park", imageName: "image", coordinates: .init(latitude: 12.12, longitude: 32.12), isFavorite: false)
        static let differentNameModel = LandmarkDetailsModel(id: 1, name: "amen", city: "city", state: "state", park: "park", imageName: "image", coordinates: .init(latitude: 12.12, longitude: 32.12), isFavorite: false)
    }
}
