//
//  LandmarkDetailsViewModel.swift
//  Places
//
//  Created by Андрей Парчуков on 03.11.2022.
//

import MapKit

struct LandmarkDetailsViewModel: Identifiable {
    let id: Int
    let name: String
    let park: String
    let state: String
    let imageName: String
    let locationCoordinate: CLLocationCoordinate2D
    let isFavorite: Bool
}
