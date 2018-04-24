//
//  Favorites.swift
//  NPF-4
//
//  Created by Oliver Haynes on 4/23/18.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

struct FavoritesManager {
    private static var favorites = [Park]()
    
    static func getFavorites() -> [Park] {
        return self.favorites
    }
    
    static func removeFromFavorites(parkName: String) -> Bool {
        if let i = self.favorites.index(where: {$0.name == parkName}) {
            self.favorites.remove(at: i)
            return true
        } else {
            return false
        }
    }
    
    static func addToFavorites(park: Park) {
        self.favorites.append(park)
    }
    
    static func isInFavorites(parkName: String) -> Bool {
        if (self.favorites.index(where: {$0.name == parkName}) != nil) {
            return true
        } else {
            return false
        }
    }
}
