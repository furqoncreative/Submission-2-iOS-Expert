//
//  RemoteDataSource.swift
//  GameCenter
//
//  Created by Dicoding Reviewer on 31/08/21.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol: AnyObject {
    func getGames() -> AnyPublisher<[GameResponse], Error>
}

final class RemoteDataSource: NSObject {
    private override init() {}
    
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
    
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    
    func getGames() -> AnyPublisher<[GameResponse], Error> {
        return Future<[GameResponse], Error> { result in
            if let url = URL(string: Endpoints.Gets.games.url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GamesResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            result(.success(value.results))
                        case .failure:
                            result(.failure(URLError.invalidResponse))
                        }
                        
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    func getGame(gameId: Int) -> AnyPublisher<GameResponse, Error> {
        return Future<GameResponse, Error> { result in
            if let url = URL(string: "\(Endpoints.Gets.game.url)\(gameId)?key=\(API.apiKey)") {
                    AF.request(url)
                    .validate()
                    .responseDecodable(of: GameResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            result(.success(value))
                        case .failure:
                            result(.failure(URLError.invalidResponse))
                        }
                        
                    }
            }
        }.eraseToAnyPublisher()
    }

}
