//
//  ListGameRow.swift
//  Game Center
//
//  Created by Dicoding Reviewer on 16/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameRow: View {
    var game: GameModel
 
    var body: some View {
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        
        VStack(alignment: .leading) {

            WebImage(url: URL(string: game.backgroundImage ?? ""))
                .resizable()
                .frame(width: screenWidth/2-16, height: screenHeight/5, alignment: .top)

            HStack(alignment: .center, spacing: 20) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(game.name).foregroundColor(ColorManager.primaryTextColor)
                        .font(.system(size: 14, weight: .bold, design: .default))
                        .frame(maxWidth: 100, alignment: .leading)
                    Text(game.released).foregroundColor(ColorManager.primaryTextColor)
                        .font(.system(size: 10, weight: .light, design: .default))
                        .frame(maxWidth: 80, alignment: .leading)
                }
                .padding(.leading, 8)
                
                VStack(alignment: .center, spacing: 1) {
                    Text("\(String(format: "%.2f", game.rating ?? 0))")
                        .font(.system(size: 10, weight: .bold, design: .default))
                        .foregroundColor(ColorManager.primaryTextColor)
        
                    Image(systemName: "star.fill")
                        .font(.system(size: 10))
                        .foregroundColor(ColorManager.primaryColor)
                    
                }
                .background(
                    Circle().foregroundColor(ColorManager.accentColor)
                        .frame(width: 40, height: 40)
                )
            
            }
            .frame(maxWidth: screenWidth/2-32, maxHeight: screenHeight/5, alignment: .center)
            .padding(.bottom, 8)
            
         }
        .frame(maxWidth: screenWidth/2-32, maxHeight: screenHeight/4+20, alignment: .top)
         .background(ColorManager.primaryColor)
         .modifier(CardModifier())
        .padding(EdgeInsets.init(top: 4, leading: 8, bottom: 4, trailing: 8))

    }
}
