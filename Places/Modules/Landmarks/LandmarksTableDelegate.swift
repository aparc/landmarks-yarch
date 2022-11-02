//
//  PlacesTableDelegate.swift
//  Places
//
//  Created by Андрей Парчуков on 01.11.2022.
//

import UIKit

class LandmarksTableDelegate: NSObject, UITableViewDelegate {
    
    // MARK: - Public Properties
    var representableViewModels: [LandmarksViewModel]
    weak var delegate: LandmarksViewControllerDelegate?
    
    // MARK: - Init Methods
    init(viewModels: [LandmarksViewModel] = []) {
        representableViewModels = viewModels
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }
        
        guard indexPath.section == 1 else { return }
        guard let viewModel = representableViewModels[safe: indexPath.row] else { return }
        delegate?.openPlaceDetails(with: viewModel.id)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 0 ? 60 : 80
    }
    
}
