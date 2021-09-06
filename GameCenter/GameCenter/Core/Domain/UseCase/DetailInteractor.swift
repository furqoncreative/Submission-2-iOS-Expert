//
//  DetailUseCase.swift
//  GameCenter
//
//  Created by Dicoding Reviewer on 31/08/21.
//

import Foundation
import Combine

protocol DetailUseCase {

    func getGame(gameId: Int) -> AnyPublisher<GameModel, Error>
    func updateFavoriteGame(game: GameEntity) -> AnyPublisher<Bool, Error>
    func isFavorite(gameId: Int) -> AnyPublisher<Bool, Error>
}

class DetailInteractor: DetailUseCase {

    private let repository: GameRepositoryProtocol
    
    required init(repository: GameRepositoryProtocol) {
      self.repository = repository
    }
    
    func getGame(gameId: Int) -> AnyPublisher<GameModel, Error> {
        return repository.getGame(gameId: gameId)
    }
    
    func updateFavoriteGame(game: GameEntity) -> AnyPublisher<Bool, Error> {
        return repository.updateFavoriteGame(game: game)
    }
    
    func isFavorite(gameId: Int) -> AnyPublisher<Bool, Error> {
        return repository.isFavorite(gameId: gameId)
    }
    
}
