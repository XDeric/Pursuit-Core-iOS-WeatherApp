//
//  SaveHelper.swift
//  WeatherApp
//
//  Created by EricM on 10/17/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct SavePersistenceHelper {
    static let manager = SavePersistenceHelper()

    func save(newFavorite: Favorite) throws {
        try persistenceHelper.save(newElement: newFavorite)
    }

    func getFavorite() throws -> [Favorite] {
        return try persistenceHelper.getObjects()
    }
    
    func replaceFavorite(replace: Favorite, index: Int) throws {
        return try persistenceHelper.replace(elements: replace, index: index)
    }
    
    func deleteFavorite(delete: Favorite, withID: Int) throws {
        return try persistenceHelper.delete(elements: delete, index: withID)
    }

    private let persistenceHelper = PersistenceHelper<Favorite>(fileName: "favorites.plist")

    private init() {}
}
