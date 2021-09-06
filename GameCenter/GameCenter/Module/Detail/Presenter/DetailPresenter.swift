//
//  DetailPresenter.swift
//  GameCenter
//
//  Created by Dicoding Reviewer on 31/08/21.
//

import Foundation
import Combine

class DetailPresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let detailUseCase: DetailUseCase
    
    @Published var game: GameModel?
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    @Published var favoriteState: Bool = false
    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
    }
    
    func getGames(gameId: Int) {
        loadingState = true
        detailUseCase.getGame(gameId: gameId)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure:
                    self.errorMessage = String(describing: result)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { game in
                self.game = game
            })
            .store(in: &cancellables)
    }
    
    func updateFavoriteGame(game: GameEntity) {
        detailUseCase.updateFavoriteGame(game: game)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure:
                    self.errorMessage = String(describing: result)
                case .finished:
                    if game.isFavorite {
                        self.favoriteState = true
                    } else {
                        self.favoriteState = false
                    }
                }
            }) { _ in }
            .store(in: &cancellables)
    }
    
    func isFavorite(gameId: Int) {
        detailUseCase.isFavorite(gameId: gameId)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in
            }) { favoriteState in
                self.favoriteState = favoriteState
            }
            .store(in: &cancellables)
    }
    
}
