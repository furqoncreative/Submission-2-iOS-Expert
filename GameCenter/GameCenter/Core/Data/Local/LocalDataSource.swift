//
//  LocalDataSource.swift
//  GameCenter
//
//  Created by Dicoding Reviewer on 31/08/21.
//

import Foundation
import Combine
import RealmSwift

protocol LocalDataSourceProtocol: AnyObject {
    func getGames() -> AnyPublisher<[GameEntity], Error>
    func addGames(from games: [GameEntity]) -> AnyPublisher<Bool, Error>
}

final class LocalDataSource: NSObject {
    private let realm: Realm?
    
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> LocalDataSource = { realmDatabase in
        return LocalDataSource(realm: realmDatabase)
    }
    
}

extension LocalDataSource: LocalDataSourceProtocol {
    
    func addGames(
        from games: [GameEntity]
    ) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { result in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for game in games {
                            realm.add(game, update: .all)
                        }
                        result(.success(true))
                    }
                } catch {
                    result(.failure(DatabaseError.requestFailed))
                }
            } else {
                result(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getGames() -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { result in
            if let realm = self.realm {
                let games: Results<GameEntity> = {
                    realm.objects(GameEntity.self)
                }()
                result(.success(games.toArray(ofType: GameEntity.self)))
            } else {
                result(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func updateFavoriteGame(
        from game: GameEntity
    ) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { result in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(game, update: .modified)
                        result(.success(true))
                    }
                } catch {
                    result(.failure(DatabaseError.requestFailed))
                }
            } else {
                result(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getFavoriteGames() -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { result in
            if let realm = self.realm {
                let games: Results<GameEntity> = {
                    realm.objects(GameEntity.self)
                        .filter("isFavorite == %@", true)
                }()
                result(.success(games.toArray(ofType: GameEntity.self)))
            } else {
                result(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func isFavorite(gameId: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { result in
            if let realm = self.realm {
                let games: Results<GameEntity> = {
                    realm.objects(GameEntity.self)
                        .filter("gameId == %@", gameId)
                        .filter("isFavorite == %@", true)
                }()
                result(.success(!games.isEmpty))
            } else {
                result(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
}

extension Results {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
    
}
