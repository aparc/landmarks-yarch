//
//  PlacesTableDataSource.swift
//  Places
//
//  Created by Андрей Парчуков on 01.11.2022.
//

import UIKit

class LandmarksTableDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Public Properties
    var representableViewModels: [LandmarksViewModel]
    
    // MARK: - Init Methods
    init(viewModels: [LandmarksViewModel] = []) {
        representableViewModels = viewModels
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        representableViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: LandmarkCell.reuseIdentifier,
            for: indexPath
        ) as? LandmarkCell
        else {
            return UITableViewCell()
        }
        guard let viewModel = representableViewModels[safe: indexPath.row] else { return cell }
        cell.configure(with: viewModel)
        
        return cell
    }
    
}
