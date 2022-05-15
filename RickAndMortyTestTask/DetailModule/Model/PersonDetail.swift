//
//  PersonDetailModel.swift
//  RickAndMortyTestTask
//
//  Created by Максим Пасюта on 14.04.2022.
//

import Foundation

// MARK: - PersonDetailModel
struct PersonDetail: Codable {
    let name, status, species, type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let url: String
}
