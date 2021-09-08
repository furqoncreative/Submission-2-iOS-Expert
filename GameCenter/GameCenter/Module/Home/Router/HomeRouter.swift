//
//  HomeRouter.swift
//  GameCenter
//
//  Created by Dicoding Reviewer on 31/08/21.
//

import SwiftUI
import Core
import Game

class HomeRouter {
    
    func makeDetailView(for game: GameModel) -> some View {
        
        let useCase: Interactor<
            Int,
            GameModel,
            GetGameRepository<
                GetGamesLocaleDataSource,
                GetGameRemoteDataSource,
                GameMapper
            >> = Injection.init().provideGame()
        
        let favoriteUseCase: Interactor<
            Int,
            GameModel,
            UpdateFavoriteGameRepository<
                GetFavoriteGamesLocaleDataSource,
                GameMapper
            >> = Injection.init().provideUpdateFavorite()
        
        let presenter = GamePresenter(gameUseCase: useCase, favoriteUseCase: favoriteUseCase)
        
        return DetailView(presenter: presenter, game: game)
    }
    
    func makeFavoriteView() -> some View {
        
        let useCase: Interactor<
            Int,
            [GameModel],
            GetFavoriteRepository<
                GetFavoriteGamesLocaleDataSource,
                GamesMapper
            >> = Injection.init().provideFavorite()
                
        let presenter = ListPresenter(useCase: useCase)
        
        return FavoriteView(presenter: presenter)
    }
    
    
}
