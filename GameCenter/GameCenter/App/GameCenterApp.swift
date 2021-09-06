//
//  GameCenterApp.swift
//  GameCenter
//
//  Created by Dicoding Reviewer on 24/08/21.
//

import SwiftUI

@main
struct GameCenterApp: App {

    var body: some Scene {
        
        let homeUseCase = Injection.init().provideHome()

        let homePresenter = HomePresenter(homeUseCase: homeUseCase)

        WindowGroup {
            HomeView(presenter: homePresenter)
        }
    }
}
