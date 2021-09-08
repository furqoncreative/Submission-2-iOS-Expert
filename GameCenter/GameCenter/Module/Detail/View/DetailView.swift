//
//  DetailView.swift
//  GameCenter
//
//  Created by Dicoding Reviewer on 31/08/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Game
import Core

struct DetailView: View {
    @State private var showingAlert = false
    
    @ObservedObject var presenter: GamePresenter<
        Interactor<Int, GameModel, GetGameRepository<GetGamesLocaleDataSource, GetGameRemoteDataSource, GameMapper>>,
        Interactor<Int, GameModel, UpdateFavoriteGameRepository<GetFavoriteGamesLocaleDataSource, GameMapper>>>
    
    var game: GameModel
    
    var body: some View {
        
        ZStack {
            ColorManager.backgroundColor.ignoresSafeArea(edges: .all)
            Group {
                if presenter.isLoading {
                    loadingIndicator
                } else
                if presenter.isError {
                    errorIndicator
                } else {
                   content
                }
            }
            .onAppear {
                if self.presenter.item == nil {
                    self.presenter.getGame(request: game.id)
                }
            }.alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Oops!"),
                    message: Text("Something wrong!"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .navigationBarItems(trailing: Group {
            self.presenter.item?.favorite == true ? Button(action: {
                self.presenter.updateFavoriteGame(request: game.id)
            }, label: {
                Image(systemName: "heart.fill")
                    .font(.title)
                    .foregroundColor(ColorManager.accentColor)
            }) : Button(action: {
                self.presenter.updateFavoriteGame(request: game.id)
            }, label: {
                Image(systemName: "heart")
                    .font(.title)
                    .foregroundColor(ColorManager.accentColor)
            })
        }
        )
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


extension DetailView {
    var loadingIndicator: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
            Text("Loading...")
        }
    }
    
    var errorIndicator: some View {
        CustomEmptyView(
            image: "assetSearchNotFound",
            title: presenter.errorMessage
        ).offset(y: 80)
    }
    
    var content: some View {
        ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: true, content: {
            WebImage(url: URL(string: presenter.item?.backgroundImage ?? ""))
                .resizable()
                .frame(height: 350)
                .modifier(ImageDetailModifier())
            
            VStack(alignment: .leading) {
                HStack(spacing: 2) {
                    Text("\(String(format: "%.2f", presenter.item?.rating ?? 0.0))")
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
                
                Text(presenter.item?.name ?? "")
                    .font(.system(size: 24, weight: .bold, design: .default))
                    .foregroundColor(ColorManager.primaryTextColor)
                
                Text(presenter.item?.released ?? "")
                    .font(.system(size: 12, weight: .regular, design: .default))
                    .foregroundColor(ColorManager.secondaryTextColor)
                    .padding(.top, 1)
                
                LazyHStack {
                    if let genres = presenter.item?.genres {
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
                
                Text(presenter.item?.description ?? "")
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
