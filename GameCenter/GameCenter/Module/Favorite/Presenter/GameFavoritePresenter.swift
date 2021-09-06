//
//  GameFavoritePresenter.swift
//  GameCenter
//
//  Created by Dicoding Reviewer on 02/09/21.
//

import Foundation
import Combine
import SwiftUI

class GameFavoritePresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let useCase: GameFavoriteUseCase
    private let router = HomeRouter()
    
    @Published var games: [GameModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(useCase: GameFavoriteUseCase) {
        self.useCase = useCase
    }
    
    func getFavoriteGames() {
        loadingState = true
        useCase.getFavoriteGames()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure:
                    self.errorMessage = String(describing: result)
                    self.loadingState = false
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { games in
                self.games = games
            })
            .store(in: &cancellables)
    }
    
    func gotoGameDetail<Content: View>(
        for game: GameModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeDetailView(for: game)) { content() }
    }
    
}
