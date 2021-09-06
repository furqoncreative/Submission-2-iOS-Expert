//
//  FavoriteEntity.swift
//  GameCenter
//
//  Created by Dicoding Reviewer on 31/08/21.
//

import Foundation
import RealmSwift

class GameEntity: Object {
    
    @objc dynamic var gameId: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var rating: Double = 0.0
    @objc dynamic var genres: String = ""
    @objc dynamic var isFavorite: Bool = false
    
    override static func primaryKey() -> String? {
        return "gameId"
    }
}
