//
//  Injection.swift
//  GameCenter
//
//  Created by Dicoding Reviewer on 31/08/21.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
    
    private func provideRepository() -> GameRepositoryProtocol {
        let realm = try? Realm()
        
        let local: LocalDataSource = LocalDataSource.sharedInstance(realm)
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return GameRepository.sharedInstance(local, remote)
    }
    
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
    func provideFavorite() -> GameFavoriteUseCase {
        let repository = provideRepository()
        return GameFavoriteInteractor(repository: repository)
    }
    
    func provideDetail(game: GameModel) -> DetailUseCase {
        let repository = provideRepository()
        return DetailInteractor(repository: repository)
    }
    
}
