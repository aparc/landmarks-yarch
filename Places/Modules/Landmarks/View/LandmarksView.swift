//
//  Created by Andrei on 01/11/2022.
//

import UIKit
import SnapKit

class LandmarksView: UIView {
    
    // MARK: - Private Properties
    private var tableView: UITableView
    
    private lazy var customView: UIView = {
        let view = UIView()
        return view
    }()
    
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
        tableDelegate: UITableViewDelegate
    ) {
        tableView = UITableView()
        super.init(frame: frame)
        configureTableView()
        addSubviews()
        makeConstraints()
        
        tableView.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func updateTableData(dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
        showTable()
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableView.reloadData()
    }
    
    // MARK: - Private Methods
    private func configureTableView() {
        tableView.register(LandmarkCell.self, forCellReuseIdentifier: LandmarkCell.reuseIdentifier)
        tableView.register(LandmarksFavoriteSwitcherCell.self, forCellReuseIdentifier: LandmarksFavoriteSwitcherCell.reuseIdentifier)
    }
    
    private func showEmptyView(title: String, subtitle: String) {
        //        show(view: emptyView)
        //        emptyView.title.text = title
        //        emptyView.subtitle.text = subtitle
    }
    
    private func showLoading() {
        show(view: spinnerView)
    }
    
    private func showError(message: String) {
        //        show(view: errorView)
        //        errorView.title.text = message
    }
    
    private func showTable() {
        show(view: tableView)
    }
    
    private func show(view: UIView) {
        subviews.forEach { $0.isHidden = $0 != view }
    }
    
    private func addSubviews(){
        addSubview(tableView)
        addSubview(spinnerView)
    }
    
    private func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.left.top.bottom.right.equalToSuperview()
        }
    }
}
