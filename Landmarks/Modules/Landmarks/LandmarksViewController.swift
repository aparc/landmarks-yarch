//
//  Displaying list of Places
//  Created by Andrei on 01/11/2022.
//

import UIKit

protocol LandmarksDisplayLogic: AnyObject {
    func displayItems(viewModel: LandmarksDataFlow.FetchLandmarks.ViewModel)
}

protocol LandmarksViewControllerDelegate: AnyObject {
    func openLandmarkDetails(with: Int)
}

class LandmarksViewController: UIViewController {
    
    // MARK: - Public Properties
    let interactor: LandmarksBusinessLogic
    
    // MARK: - Private Properties
    private var state: LandmarksDataFlow.ViewControllerState
    
    private let landmarksTableDataSource: LandmarksTableDataSource = LandmarksTableDataSource()
    private let landmarksTableDelegate: LandmarksTableDelegate = LandmarksTableDelegate()
    
    private lazy var landmarksView = view as? LandmarksView
    
    // MARK: - Init Methods
    init(
        interactor: LandmarksBusinessLogic,
        initialState: LandmarksDataFlow.ViewControllerState = .loading(onlyFavorites: false)
    ) {
        self.interactor = interactor
        self.state = initialState
        super.init(nibName: nil, bundle: nil)
        
        landmarksTableDelegate.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View lifecycle
    override func loadView() {
        super.loadView()
        let view = LandmarksView(
            frame: UIScreen.main.bounds,
            tableDataSource: landmarksTableDataSource,
            tableDelegate: landmarksTableDelegate,
            favoriteSwitcherdelegate: self,
            errorViewDelegate: self
        )
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        display(newState: state)
    }
    
    // MARK: - Public Methods
    func fetchItems(request: LandmarksDataFlow.FetchLandmarks.Request = .init()) {
        interactor.fetchLandmarks(request: request)
    }
    
    // MARK: - Private Methods
    private func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Landmarks"
    }
}

// MARK: - PlacesDisplayLogic
extension LandmarksViewController: LandmarksDisplayLogic {
    
    func displayItems(viewModel: LandmarksDataFlow.FetchLandmarks.ViewModel) {
        display(newState: viewModel.state)
    }
    
    private func display(newState: LandmarksDataFlow.ViewControllerState) {
        state = newState
        switch state {
        case let .loading(onlyFavorites):
            landmarksView?.showLoading()
            fetchItems(request: .init(onlyFavorites: onlyFavorites))
        case let .error(message):
            landmarksView?.showError(message: message)
        case let .result(items):
            landmarksTableDataSource.representableViewModels = items
            landmarksTableDelegate.representableViewModels = items
            landmarksView?.updateTableData()
        case .emptyResult:
            landmarksTableDataSource.representableViewModels = []
            landmarksTableDelegate.representableViewModels = []
            landmarksView?.showEmptyView()
        }
    }
    
}

// MARK: - LandmarksViewControllerDelegate
extension LandmarksViewController: LandmarksViewControllerDelegate {
    func openLandmarkDetails(with id: Int) {
        let detailsController = LandmarkDetailsBuilder().set(initialState: .initial(landmarkId: id)).build()
        navigationController?.pushViewController(detailsController, animated: true)
    }
}

// MARK: - LandmarksFavoriteSwitcherDelegate
extension LandmarksViewController: LandmarksFavoriteSwitcherDelegate {
    func showFavorites(_ on: Bool) {
        display(newState: .loading(onlyFavorites: on))
    }
}

// MARK: - LandmarksErrorViewDelegate
extension LandmarksViewController: LandmarksErrorViewDelegate {
    func reloadButtonWasTapped() {
        display(newState: .loading(onlyFavorites: false))
    }
}
