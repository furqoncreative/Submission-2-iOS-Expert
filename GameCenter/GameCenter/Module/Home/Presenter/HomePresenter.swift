//
//  HomePresenter.swift
//  GameCenter
//
//  Created by Dicoding Reviewer on 31/08/21.
//

import Foundation
import Combine
import SwiftUI

class HomePresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let homeUseCase: HomeUseCase
    private let router = HomeRouter()
    
    @Published var games: [GameModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func getGames() {
        loadingState = true
        homeUseCase.getGames()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure:
                    self.errorMessage = String(describing: result)
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
    
    func gotoGameFavorite() -> some View {
        NavigationLink(
            destination: router.makeFavoriteView(), label: {
                Image(systemName: "heart.fill")
                    .font(.title)
                    .foregroundColor(ColorManager.accentColor)
            })
    }
}
