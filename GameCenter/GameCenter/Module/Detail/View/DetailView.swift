//
//  DetailView.swift
//  GameCenter
//
//  Created by Dicoding Reviewer on 31/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    @ObservedObject var presenter: DetailPresenter
    let gameId: Int
    
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
                    ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: true, content: {
                        WebImage(url: URL(string: presenter.game?.backgroundImage ?? ""))
                            .resizable()
                            .frame(height: 350)
                            .modifier(ImageDetailModifier())
                        
                        VStack(alignment: .leading) {
                            HStack(spacing: 2) {
                                Text("\(String(format: "%.2f", presenter.game?.rating ?? 0.0))")
                                    .font(.system(size: 12, weight: .bold, design: .default))
                                    .foregroundColor(ColorManager.primaryTextColor)
                                
                                Image(systemName: "star.fill")
                                    .font(.system(size: 10))
                                    .foregroundColor(ColorManager.primaryColor)
                                
                            }
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .padding(.all, 4)
                            .frame(width: 70, height: 30)
                            .background(Rectangle().fill(ColorManager.accentColor).cornerRadius(20))
                            
                            Text(presenter.game?.name ?? "Null")
                                .font(.system(size: 24, weight: .bold, design: .default))
                                .foregroundColor(ColorManager.primaryTextColor)
                            
                            Text(presenter.game?.released ?? "Null")
                                .font(.system(size: 12, weight: .regular, design: .default))
                                .foregroundColor(ColorManager.secondaryTextColor)
                                .padding(.top, 1)
                            
                            LazyHStack {
                                if let genres = presenter.game?.genres {
                                    if !genres.isEmpty {
                                        ScrollView(.horizontal) {
                                            HStack {
                                                ForEach(genres) { genre in
                                                    GenreView(genre: genre.name ?? "Uknown")
                                                }
                                            }
                                        }
                                    }
                                }
                            }.frame(height: 25)
                            
                            Text(presenter.game?.description ?? "Null")
                                .font(.system(size: 14, weight: .light, design: .default))
                            
                        }
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            minHeight: 0,
                            maxHeight: .infinity,
                            alignment: .topLeading
                        )
                        
                    })
                    
                    .ignoresSafeArea(edges: .all)
                    .background(ColorManager.backgroundColor)
                }
            }
            .onAppear {
                self.presenter.isFavorite(gameId: gameId)
                if self.presenter.game == nil {
                    self.presenter.getGames(gameId: gameId)
                }
            }
        }
        .navigationBarItems(trailing: Group {
            self.presenter.favoriteState ? Button(action: {
                updateFavoriteGame(isFavorite: false)
            }, label: {
                Image(systemName: "heart.fill")
                    .font(.title)
                    .foregroundColor(ColorManager.accentColor)
            }) : Button(action: {
                updateFavoriteGame(isFavorite: true)
            }, label: {
                Image(systemName: "heart")
                    .font(.title)
                    .foregroundColor(ColorManager.accentColor)
            })
        }
        )
    }
    
    func updateFavoriteGame(isFavorite: Bool) {
        let game = GameMapper.mapGameDomainToEntity(input: presenter.game, favoriteSate: isFavorite)
        self.presenter.updateFavoriteGame(game: game)
    }
}

struct GenreView: View {
    let genre: String
    var body: some View {
        Text(genre)
            .fixedSize(horizontal: false, vertical: true)
            .font(.system(size: 10, weight: .light, design: .default))
            .multilineTextAlignment(.center)
            .padding(.all, 8)
            .frame(maxWidth: 65, maxHeight: 25)
            .background(Rectangle().fill(ColorManager.primaryColor).cornerRadius(20))
    }
}
