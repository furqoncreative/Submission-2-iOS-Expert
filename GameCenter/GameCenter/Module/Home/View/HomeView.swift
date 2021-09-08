//
//  ContentView.swift
//  GameCenter
//
//  Created by Dicoding Reviewer on 24/08/21.
//

import SwiftUI
import Core
import Game

struct HomeView: View {
    
    @ObservedObject var presenter: ListPresenter<Int, GameModel, Interactor<Int, [GameModel], GetGamesRepository<GetGamesLocaleDataSource, GetGamesRemoteDataSource, GamesMapper>>>
        
    
    var body: some View {
        NavigationView {
            ZStack {
                ColorManager.backgroundColor.ignoresSafeArea( edges: .all)
                Group {
                    if presenter.isLoading {
                        loadingIndicator
                    } else if presenter.isError {
                        errorIndicator
                    } else if presenter.list.isEmpty {
                        emptyGames
                    } else {
                        content
                    }
                }.onAppear {
                    if self.presenter.list.count == 0 {
                        self.presenter.getList(request: nil)
                    }
                }
            }
            .navigationBarTitle(
                Text("Game Center"),
                displayMode: .automatic
            )
            .navigationBarItems(trailing:
                                    HStack {
                                        NavigationLink(
                                            destination: HomeRouter().makeFavoriteView(),
                                            label: {
                                                Image(systemName: "heart.fill")
                                                    .font(.title)
                                                    .foregroundColor(ColorManager.accentColor)
                                            })
                                        NavigationLink(
                                            destination: AboutView(),
                                            label: {
                                                Image(systemName: "person.fill")
                                                    .font(.title)
                                                    .foregroundColor(ColorManager.accentColor)
                                            })
                                    }
                                
            )
        }
    }
}

extension HomeView {
    
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
    
    var emptyGames: some View {
        CustomEmptyView(
            image: "noFavorite",
            title: "There is no Games"
        ).offset(y: 80)
    }
    
    var content: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 2), spacing: 2) {
                ForEach(
                    self.presenter.list,
                    id: \.id
                ) { game in
                    ZStack {
                        linkBuilder(for: game) {
                            GameRow(game: game)
                        }
                    }.padding(4)
                }
            }.padding()
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
