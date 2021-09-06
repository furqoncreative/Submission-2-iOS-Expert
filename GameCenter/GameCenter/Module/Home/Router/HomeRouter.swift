//
//  HomeRouter.swift
//  GameCenter
//
//  Created by Dicoding Reviewer on 31/08/21.
//

import SwiftUI

class HomeRouter {
    
    func makeDetailView(for game: GameModel) -> some View {
        let detailUseCase = Injection.init().provideDetail(game: game)
        let presenter = DetailPresenter(detailUseCase: detailUseCase)
        return DetailView(presenter: presenter, gameId: game.id)
    }
    
    func makeFavoriteView() -> some View {
        let useCase = Injection.init().provideFavorite()
        let presenter = GameFavoritePresenter(useCase: useCase)
        return GameFavoriteView(presenter: presenter)
    }
    
}
