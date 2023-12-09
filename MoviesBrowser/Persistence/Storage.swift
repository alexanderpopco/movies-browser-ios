//
//  Storage.swift
//  MoviesBrowser
//
//  Created by Aleksander Popko on 09/12/2023.
//

import Foundation

private struct StorageKeys {
    static let favouriteMoviesIds = "favouriteMoviesIds"
}

struct Storage {
    
    private let userDefaults = UserDefaults()
    
    func favourtieMoviesIds() -> [String]? {
        return userDefaults.array(forKey: StorageKeys.favouriteMoviesIds) as? [String]
    }
    
    func saveMovieAsFavourite(movieId: String) {
        var movieIds = favourtieMoviesIds()
        movieIds?.append(movieId)
        userDefaults.set(movieIds, forKey: StorageKeys.favouriteMoviesIds)
    }
    
    func removeMovieFromFavourites(movieId: String) {
        var movieIds = favourtieMoviesIds()
        movieIds?.append(movieId)
        userDefaults.set(movieIds, forKey: StorageKeys.favouriteMoviesIds)
        
    }
}
