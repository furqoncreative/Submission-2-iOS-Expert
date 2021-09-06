//
//  GameModel.swift
//  GameCenter
//
//  Created by Dicoding Reviewer on 31/08/21.
//

import Foundation

struct GameModel: Equatable, Identifiable {
    let id: Int
    let name, released, description: String
    let backgroundImage: String?
    let rating: Double?
    let genres: [GenreModel]
}

struct GenreModel: Equatable, Identifiable {
    let id: Int?
    let name: String?
}
