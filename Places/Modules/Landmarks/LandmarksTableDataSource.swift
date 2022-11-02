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
    weak var delegate: LandmarksViewControllerDelegate?
    
    // MARK: - Init Methods
    init(viewModels: [LandmarksViewModel] = []) {
        representableViewModels = viewModels
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 1 : representableViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: LandmarksFavoriteSwitcherCell.reuseIdentifier,
                for: indexPath
            ) as? LandmarksFavoriteSwitcherCell
            else {
                return UITableViewCell()
            }
            cell.delegate = delegate
            return cell
        }
        
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
