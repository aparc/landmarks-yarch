//
//  Created by Andrei on 01/11/2022.
//

import UIKit
import SnapKit

extension LandmarksView {
    struct Appearance {
        let backgroundColor: UIColor = .white
        let switcherViewHeight: CGFloat = 60
    }
}

class LandmarksView: UIView {
    
    // MARK: - Private Properties
    private let appearance = Appearance()
    
    private var tableView: UITableView
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = appearance.backgroundColor
        return view
    }()
    
    private lazy var tableBackgroundView: UIView = UIView()
    
    private lazy var landmarkSwitcherView = LandmarksFavoriteSwitcherView()
    
    private lazy var emptyView = LandmarksEmptyView()
    
    private lazy var errorView = LandmarkErrorView()
    
    private lazy var spinnerView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        return activityIndicator
    }()
    
    
    // MARK: - Init Methods
    init(
        frame: CGRect = CGRect.zero,
        tableDataSource: UITableViewDataSource,
        tableDelegate: UITableViewDelegate,
        favoriteSwitcherdelegate: LandmarksFavoriteSwitcherDelegate,
        errorViewDelegate: LandmarksErrorViewDelegate? = nil
    ) {
        tableView = UITableView()
        super.init(frame: frame)
        
        landmarkSwitcherView.delegate = favoriteSwitcherdelegate
        errorView.delegate = errorViewDelegate
        
        configureTableView(dataSource: tableDataSource, delegate: tableDelegate)
        addSubviews()
        makeConstraints()
        
        spinnerView.isHidden = true
        emptyView.isHidden = true
        errorView.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func updateTableData() {
        showTable()
        tableView.reloadData()
    }
    
    func showEmptyView() {
        updateTableData()
        showInTableBackground(view: emptyView)
    }
    
    func showLoading() {
        showTable()
        showInTableBackground(view: spinnerView)
    }
    
    func showError(message: String) {
        errorView.title.text = message
        show(view: errorView)
    }
    
    // MARK: - Private Methods
    private func configureTableView(dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
        landmarkSwitcherView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: appearance.switcherViewHeight)
        tableView.tableHeaderView = landmarkSwitcherView
        tableView.backgroundView = tableBackgroundView
        tableView.register(LandmarkCell.self, forCellReuseIdentifier: LandmarkCell.reuseIdentifier)
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        updateTableData()
    }
    
    private func showTable() {
        show(view: tableView)
    }
    
    private func show(view: UIView) {
        subviews.forEach { $0.isHidden = $0 != view }
    }
    
    private func showInTableBackground(view: UIView) {
        tableBackgroundView.subviews.forEach { $0.isHidden = $0 != view }
    }
    
    private func addSubviews(){
        tableBackgroundView.addSubview(spinnerView)
        tableBackgroundView.addSubview(emptyView)
        
        addSubview(tableView)
        addSubview(errorView)
    }
    
    // MARK: - Layout
    private func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        spinnerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        errorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
