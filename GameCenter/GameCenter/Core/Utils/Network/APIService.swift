//
//  Endpoints.swift
//  GameCenter
//
//  Created by Dicoding Reviewer on 31/08/21.
//

import Foundation

struct API {

  static let baseUrl = "https://api.rawg.io/api/"
    
  static var apiKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "GameCenter", ofType: "plist") else {
                fatalError("Couldn't find file 'GameCenter.plist'.")
            }

            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API_KEY") as? String else {
                fatalError("Couldn't find key 'API_KEY' in 'GameCenter.plist'.")
            }
    
            if value.starts(with: "_") {
                fatalError("Error")
            }
            return value
        }
    }
}

protocol Endpoint {
    
  var url: String { get }
    
}

enum Endpoints {
  
  enum Gets: Endpoint {
    case games
    case game
    
    public var url: String {
      switch self {
      case .games: return "\(API.baseUrl)games?key=\(API.apiKey)"
      case .game: return "\(API.baseUrl)games/"
      }
    }
  }
  
}
