//
//  DetailGame.swift
//  Game Center
//
//  Created by Dicoding Reviewer on 16/08/21.
//

import Foundation

// MARK: - DetailGame
struct Game: Codable {
    let gameId: Int
    let name, released, description: String
    let backgroundImage: String?
    let rating: Double?
    let genres: [Genre]

    enum CodingKeys: String, CodingKey {
        case name, released, rating, genres
        case backgroundImage = "background_image"
        case description = "description_raw"
        case gameId = "id"
    }
}

// MARK: - Genre
struct Genre: Codable, Identifiable {
    let id: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
