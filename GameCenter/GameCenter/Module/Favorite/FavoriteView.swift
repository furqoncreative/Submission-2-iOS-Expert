//
//  FavoriteView.swift
//  GameCenter
//
//  Created by Dicoding Reviewer on 08/09/21.
//

import SwiftUI
import Core
import Game

struct FavoriteView: View {
    @ObservedObject var presenter: ListPresenter<Int, GameModel, Interactor<Int, [GameModel], GetFavoriteRepository<GetFavoriteGamesLocaleDataSource, GamesMapper>>>
    
    var body: some View {
        ZStack {
            if presenter.isLoading {
                loadingIndicator
            } else if presenter.isError {
                errorIndicator
            } else if presenter.list.count == 0 {
                emptyFavorites
            } else {
                content
            }
        }.onAppear {
            self.presenter.getList(request: nil)
        }.navigationBarTitle(
            Text("Favorite"),
            displayMode: .automatic
        )
    }
    
}

extension FavoriteView {
    var loadingIndicator: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
            Text("Loading...")
        }
    }
    
    var errorIndicator: some View {
        CustomEmptyView(
            image: "notFound",
            title: presenter.errorMessage
        ).offset(y: 80)
    }
    
    var emptyFavorites: some View {
        ScrollView {
            CustomEmptyView(
                image: "noFavorite",
                title: "There is no favorite"
            ).offset(y: 80)
        }
    }
    
    var content: some View {
        List {
            ForEach(
                self.presenter.list,
                id: \.id
            ) { game in
                VStack {
                    self.linkBuilder(for: game) {
                        GameFavoriteRow(favorite: game)
                    }
                }
            }
            
        }
        
    }
    
    func linkBuilder<Content: View>(
        for game: GameModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        
        NavigationLink(
            destination: HomeRouter().makeDetailView(for: game)
        ) { content() }
    }
}
