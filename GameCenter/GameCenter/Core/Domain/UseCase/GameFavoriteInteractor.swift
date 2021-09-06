//
//  GameFavorite.swift
//  GameCenter
//
//  Created by Dicoding Reviewer on 02/09/21.
//

import Foundation
import Combine

protocol GameFavoriteUseCase {
    
    func getFavoriteGames() -> AnyPublisher<[GameModel], Error>
    
}

class GameFavoriteInteractor: GameFavoriteUseCase {
    let repository: GameRepositoryProtocol
    
    required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFavoriteGames() -> AnyPublisher<[GameModel], Error> {
        return repository.getFavoriteGames()
    }
    
}
