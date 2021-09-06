//
//  GameFavoriteView.swift
//  GameCenter
//
//  Created by Dicoding Reviewer on 01/09/21.
//

import SwiftUI

struct GameFavoriteView: View {
    @ObservedObject var presenter: GameFavoritePresenter
    
    var body: some View {
        ZStack {
            ColorManager.backgroundColor.ignoresSafeArea(edges: .all)
            Group {
                if presenter.loadingState {
                    VStack {
                        VStack(spacing: 16.0) {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                            Text("Loading...")
                        }
                    }
                } else {
                    if !presenter.games.isEmpty {
                        List {
                            ForEach(
                                self.presenter.games,
                                id: \.id
                            ) { game in
                                VStack {
                                    self.presenter.gotoGameDetail(for: game) {
                                        GameFavoriteRow(favorite: game)
                                    }
                                }
                            }
                            
                        }
                    } else {
                        VStack {
                            Text("There is no favorite")
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Favorite"))
        }.onAppear {
            self.presenter.getFavoriteGames()
        }
    }
}
