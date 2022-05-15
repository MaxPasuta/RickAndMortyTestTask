//
//  PersonsModel.swift
//  RickAndMortyTestTask
//
//  Created by Максим Пасюта on 14.04.2022.
//

import Foundation

// MARK: - PersonsModel
struct Persons: Codable {
    let info: Info
    let results: [Result]
}

// MARK: - Info
struct Info: Codable {
    let next: String?
}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let name: String
    let species: String
    let gender: String
    let image: String
}

