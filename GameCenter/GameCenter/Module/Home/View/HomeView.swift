//
//  ContentView.swift
//  GameCenter
//
//  Created by Dicoding Reviewer on 24/08/21.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var presenter: HomePresenter
    @State private var isSearch = false
    
    private var gridItemLayout = Array(repeating: GridItem(.flexible(), spacing: 0), count: 2)
    
    init(presenter: HomePresenter) {
        self.presenter = presenter
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ColorManager.backgroundColor.ignoresSafeArea( edges: .all)
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
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVGrid(columns: gridItemLayout, spacing: 2) {
                                ForEach(
                                    self.presenter.games,
                                    id: \.id
                                ) { game in
                                    ZStack {
                                        self.presenter.gotoGameDetail(for: game) {
                                            GameRow(game: game)
                                        }
                                    }.padding(4)
                                }
                            }.padding()
                        }
                    }
                    
                }.onAppear {
                    if self.presenter.games.count == 0 {
                        self.presenter.getGames()
                    }
                }
            }
            .navigationBarTitle(
                Text("Game Center"),
                displayMode: .automatic
            )
            .navigationBarItems(trailing:
                                    HStack {
                                        self.presenter.gotoGameFavorite()
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
