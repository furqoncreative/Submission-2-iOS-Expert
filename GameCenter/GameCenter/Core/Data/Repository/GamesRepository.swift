//
//  GameRepository.swift
//  GameCenter
//
//  Created by Dicoding Reviewer on 31/08/21.
//

import Foundation
import Combine

protocol GameRepositoryProtocol {
    
    func getGames() -> AnyPublisher<[GameModel], Error>
    func getFavoriteGames() -> AnyPublisher<[GameModel], Error>
    func getGame(gameId: Int) -> AnyPublisher<GameModel, Error>
    func updateFavoriteGame(game: GameEntity) -> AnyPublisher<Bool, Error>
    func isFavorite(gameId: Int) -> AnyPublisher<Bool, Error>
}

final class GameRepository: NSObject {
    
    typealias GameInstance = (LocalDataSource, RemoteDataSource) -> GameRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let local: LocalDataSource
    
    private init(local: LocalDataSource, remote: RemoteDataSource) {
        self.local = local
        self.remote = remote
    }
    
    static let sharedInstance: GameInstance = { localRepo, remoteRepo in
        return GameRepository(local: localRepo, remote: remoteRepo)
    }
    
}

extension GameRepository: GameRepositoryProtocol {

    func getGames() -> AnyPublisher<[GameModel], Error> {
        return self.local.getGames()
            .flatMap { result -> AnyPublisher<[GameModel], Error> in
                if result.isEmpty {
                    return self.remote.getGames()
                        .map { GameMapper.mapGamesResponseToEntities(input: $0) }
                        .flatMap { self.local.addGames(from: $0) }
                        .filter { $0 }
                        .flatMap { _ in self.local.getGames()
                            .map {
                                GameMapper.mapGamesEntitiesToDomains(input: $0)
                            }
                        }
                        .eraseToAnyPublisher()
                } else { return self.local.getGames()
                    .map {
                        GameMapper.mapGamesEntitiesToDomains(input: $0)
                    }
                    .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    func isFavorite(gameId: Int) -> AnyPublisher<Bool, Error> {
        return self.local.isFavorite(gameId: gameId).eraseToAnyPublisher()
    }
    
    func updateFavoriteGame(game: GameEntity) -> AnyPublisher<Bool, Error> {
        return self.local.updateFavoriteGame(from: game).eraseToAnyPublisher()
    }
    
    func getFavoriteGames() -> AnyPublisher<[GameModel], Error> {
        return self.local.getFavoriteGames()
            .map { GameMapper.mapGamesEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func getGame(gameId: Int) -> AnyPublisher<GameModel, Error> {
        return self.remote.getGame(gameId: gameId)
            .map { GameMapper.mapGameResponseToDomain(input: $0)}
            .eraseToAnyPublisher()
    }
    
}
