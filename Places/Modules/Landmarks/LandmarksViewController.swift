//
//  Displaying list of Places
//  Created by Andrei on 01/11/2022.
//

import UIKit

protocol LandmarksDisplayLogic: AnyObject {
    func displayItems(viewModel: Landmarks.FetchLandmarks.ViewModel)
}

protocol LandmarksViewControllerDelegate: AnyObject {
    func openPlaceDetails(with: Int)
    func showFavorites(_ on: Bool)
}

class LandmarksViewController: UIViewController {
    
    // MARK: - Private Properties
    private let interactor: LandmarksBusinessLogic
    private var state: Landmarks.ViewControllerState
    
    private let placesTableDataSource: LandmarksTableDataSource = LandmarksTableDataSource()
    private let placesTableDelegate: LandmarksTableDelegate = LandmarksTableDelegate()
    
    private lazy var placesView = view as? LandmarksView
    
    // MARK: - Initializators
    init(
        interactor: LandmarksBusinessLogic,
        initialState: Landmarks.ViewControllerState = .loading
    ) {
        self.interactor = interactor
        self.state = initialState
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View lifecycle
    override func loadView() {
        super.loadView()
        let view = LandmarksView(
            frame: UIScreen.main.bounds,
            tableDataSource: placesTableDataSource,
            tableDelegate: placesTableDelegate
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
    
    // MARK: Fetching
    private func fetchItems(request: Landmarks.FetchLandmarks.Request = .init()) {
//        let request = Places.FetchPlaces.Request()
        interactor.fetchLandmarks(request: request)
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Landmarks"
    }
}

// MARK: - PlacesDisplayLogic
extension LandmarksViewController: LandmarksDisplayLogic {
    
    func displayItems(viewModel: Landmarks.FetchLandmarks.ViewModel) {
        display(newState: viewModel.state)
    }
    
    private func display(newState: Landmarks.ViewControllerState) {
        state = newState
        switch state {
        case .loading:
            fetchItems()
        case let .error(message):
            print("error \(message)")
        case let .result(items):
            placesTableDataSource.delegate = self
            placesTableDelegate.delegate = self
            placesTableDataSource.representableViewModels = items
            placesTableDelegate.representableViewModels = items
            placesView?.updateTableData(dataSource: placesTableDataSource, delegate: placesTableDelegate)
        case .emptyResult:
            print("empty result")
        }
    }
    
}

// MARK: - LandmarksViewControllerDelegate
extension LandmarksViewController: LandmarksViewControllerDelegate {
    func openPlaceDetails(with id: Int) {
        let detailsController = LandmarkDetailsBuilder().build()
        navigationController?.pushViewController(detailsController, animated: true)
    }
    
    func showFavorites(_ on: Bool) {
        fetchItems(request: .init(onlyFavorites: on))
    }
    
}
