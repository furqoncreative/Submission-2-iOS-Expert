//
//  HomeInteractor.swift
//  GameCenter
//
//  Created by Dicoding Reviewer on 31/08/21.
//

import Foundation
import Combine

protocol HomeUseCase {

  func getGames() -> AnyPublisher<[GameModel], Error>

}

class HomeInteractor: HomeUseCase {

  private let repository: GameRepositoryProtocol
  
  required init(repository: GameRepositoryProtocol) {
    self.repository = repository
  }
  
  func getGames() -> AnyPublisher<[GameModel], Error> {
    return repository.getGames()
  }

}
