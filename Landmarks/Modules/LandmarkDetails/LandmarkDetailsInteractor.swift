//
//  Present landmark details
//  Created by Andrei on 02/11/2022.
//

protocol LandmarkDetailsBusinessLogic {
    func getLandmarkDetails(request: LandmarkDetailsDataFlow.FetchLandmarkDetails.Request)
}

class LandmarkDetailsInteractor: LandmarkDetailsBusinessLogic {
    
    let presenter: LandmarkDetailsPresentationLogic
    let provider: LandmarkDetailsProviderProtocol

    init(presenter: LandmarkDetailsPresentationLogic, provider: LandmarkDetailsProviderProtocol = LandmarkDetailsProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    func getLandmarkDetails(request: LandmarkDetailsDataFlow.FetchLandmarkDetails.Request) {
        provider.getLandmarkDetails(by: request.id) { landmark in
            let result: LandmarkDetailsDataFlow.LandmarkDetailsRequestResult
            if let landmark = landmark {
                result = .success(landmark)
            } else {
                result = .failure(.someError(message: "No Data"))
            }
            
            self.presenter.presentLandmarkDetails(response: LandmarkDetailsDataFlow.FetchLandmarkDetails.Response(result: result))
        }
    }
}
