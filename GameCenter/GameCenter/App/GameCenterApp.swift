//
//  GameCenterApp.swift
//  GameCenter
//
//  Created by Dicoding Reviewer on 06/09/21.
//

import SwiftUI
import Core
import Game

@main
struct GameCenterApp: App {
    
    var body: some Scene {

        let injection = Injection()
        
        WindowGroup {
            let gameUseCase: Interactor< Int, [GameModel],
                GetGamesRepository<
                    GetGamesLocaleDataSource,
                    GetGamesRemoteDataSource,
                    GamesMapper>> = injection.provideGames()
            
            let homePresenter = ListPresenter(useCase: gameUseCase)
            HomeView(presenter: homePresenter)
        }
    }
    
}
