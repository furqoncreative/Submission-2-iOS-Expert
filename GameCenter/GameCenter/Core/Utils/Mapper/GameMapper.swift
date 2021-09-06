//
//  GameMapper.swift
//  GameCenter
//
//  Created by Dicoding Reviewer on 31/08/21.
//

import Foundation

final class GameMapper {
    
    static func mapGamesResponseToEntities(
        input gameResponse: [GameResponse]
    ) -> [GameEntity] {
        return gameResponse.map { result in
            print(result)
            let newGame = GameEntity()
            newGame.gameId = result.id ?? 0
            newGame.name = result.name ?? "Unknown"
            newGame.desc = result.description ?? "Uknown"
            newGame.image = result.backgroundImage ?? "Unknown"
            newGame.rating = result.rating ?? 0.0
            newGame.releaseDate = result.released ?? "Unknown"
            newGame.genres = result.genres.map { $0.name ?? "Unknown" }.joined(separator: ",") 
            return newGame
        }
    }
    
    static func mapGamesEntitiesToDomains(
        input gameEntities: [GameEntity]
    ) -> [GameModel] {
        return gameEntities.map { result in
            
            let genres = result.genres.split(separator: ",").map {
                return GenreModel(id: $0.startIndex, name: String($0))
            }
            return GameModel(
                id: result.gameId,
                name: result.name,
                released: result.releaseDate,
                description: result.desc,
                backgroundImage: result.image,
                rating: result.rating,
                genres: genres
            )
        }
    }
    
    static func mapGamesResponseToDomains(
        input gameResponse: [GameResponse]
    ) -> [GameModel] {
        return gameResponse.map { result in
            
            let genres = result.genres.map { GenreModel(id: $0.id, name: $0.name)}
            return GameModel(
                id: result.id ?? 0,
                name: result.name ?? "",
                released: result.released ?? "",
                description: result.description ?? "Uknown Remote",
                backgroundImage: result.backgroundImage,
                rating: result.rating,
                genres: genres)
        }
    }
    
    static func mapGameResponseToDomain(
        input gameResponse: GameResponse
    ) -> GameModel {
        let genres = gameResponse.genres.map { GenreModel(id: $0.id, name: $0.name)}
        return GameModel(
            id: gameResponse.id ?? 0,
            name: gameResponse.name ?? "",
            released: gameResponse.released ?? "",
            description: gameResponse.description ?? "Uknown Remote",
            backgroundImage: gameResponse.backgroundImage,
            rating: gameResponse.rating,
            genres: genres
        )
    }
    
    static func mapGameDomainToEntity(
        input gameModel: GameModel?,
        favoriteSate: Bool
    ) -> GameEntity {
        let game = GameEntity()
        game.gameId = gameModel?.id ?? 0
        game.name = gameModel?.name ?? "Unknown"
        game.desc = gameModel?.description ?? "Unknown"
        game.image = gameModel?.backgroundImage ?? "Unknown"
        game.rating = gameModel?.rating ?? 0.0
        game.releaseDate = gameModel?.released ?? "Unknown"
        game.genres = gameModel?.genres.map { $0.name ?? "Unknown" }.joined(separator: ",") ?? "Unknown"
        game.isFavorite = favoriteSate
        return game
    }
}
