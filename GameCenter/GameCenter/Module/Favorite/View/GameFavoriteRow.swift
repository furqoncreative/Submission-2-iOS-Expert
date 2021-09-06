//
//  ListFavoriteRowView.swift
//  Game Center
//
//  Created by Dicoding Reviewer on 23/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameFavoriteRow: View {
    let favorite: GameModel
    
    var body: some View {
        HStack {
            WebImage(url: URL(string: favorite.backgroundImage ?? ""))
                .resizable()
                .frame(width: 100, height: 80, alignment: .top)
            VStack(alignment: .leading) {
                Text(favorite.name)
                    .font(.headline)
                Text(favorite.released)
                    .foregroundColor(.secondary)
                HStack {
                    Image(systemName: "star.fill")
                        .font(.system(size: 12))
                        .foregroundColor(ColorManager.accentColor)
                    Text("\(String(format: "%.2f", favorite.rating ?? 0.0))")
                        .foregroundColor(.secondary)
                }
                
            }
        }
    }
}
