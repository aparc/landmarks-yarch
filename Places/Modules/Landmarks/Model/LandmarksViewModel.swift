//
//  PlacesViewModel.swift
//  Places
//
//  Created by Андрей Парчуков on 01.11.2022.
//

import Foundation

struct LandmarksViewModel: Identifiable {
    let id: Int
    let name: String
    let imageName: String
    let isFavorite: Bool
}

extension LandmarksViewModel: Equatable {
    static func == (lhs: LandmarksViewModel, rhs: LandmarksViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
