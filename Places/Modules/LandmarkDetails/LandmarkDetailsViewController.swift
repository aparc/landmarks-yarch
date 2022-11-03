//
//  Present landmark details
//  Created by Andrei on 02/11/2022.
//

import UIKit


protocol LandmarkDetailsDisplayLogic: AnyObject {
    func displayDetails(viewModel: LandmarkDetailsDataFlow.FetchLandmarkDetails.ViewModel)
}

class LandmarkDetailsViewController: UIViewController {

    // MARK: - Public Properties
    let interactor: LandmarkDetailsBusinessLogic
    
    // MARK: - Private Properties
    private var state: LandmarkDetailsDataFlow.ViewControllerState {
        didSet(previousState) {
            switch (previousState, state) {
            case let (.initial(landmarkId), .loading):
                applyLoadingState(id: landmarkId)
            case let (_, .result(viewModel)):
                applyResult(viewModel)
            default:
                break
            }
        }
    }
    
    private lazy var landmarkDetailsView = view as? LandmarkDetailsView
    
    // MARK: - Init Methods
    init(interactor: LandmarkDetailsBusinessLogic, initialState: LandmarkDetailsDataFlow.ViewControllerState = .loading) {
        self.interactor = interactor
        self.state = initialState
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View lifecycle
    override func loadView() {
        super.loadView()
        let view = LandmarkDetailsView(frame: UIScreen.main.bounds)
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        state = .loading
    }

    // MARK: - Public Methods
    func fetchLandmarkDetails(landmarkId: Int) {
        let request = LandmarkDetailsDataFlow.FetchLandmarkDetails.Request(id: landmarkId)
        interactor.getLandmarkDetails(request: request)
    }
    
    // MARK: - Private Methods
    private func setupNavBar() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func applyLoadingState(id: Int) {
        fetchLandmarkDetails(landmarkId: id)
    }
    
    private func applyResult(_ viewModel: LandmarkDetailsViewModel) {
        title = viewModel.name
        landmarkDetailsView?.configureView(with: viewModel)
    }
}

// MARK: - LandmarkDetailsDisplayLogic
extension LandmarkDetailsViewController: LandmarkDetailsDisplayLogic {
    func displayDetails(viewModel: LandmarkDetailsDataFlow.FetchLandmarkDetails.ViewModel) {
        state = viewModel.state
    }
}
