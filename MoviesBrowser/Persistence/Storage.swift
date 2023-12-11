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
    
    func favourtieMoviesIds() -> [Int] {
        return userDefaults.array(forKey: StorageKeys.favouriteMoviesIds) as? [Int] ?? [Int]()
    }
    
    func saveMovieAsFavourite(movieId: Int) {
        var movieIds = favourtieMoviesIds()
        movieIds.append(movieId)
        userDefaults.set(movieIds, forKey: StorageKeys.favouriteMoviesIds)
    }
    
    func removeMovieFromFavourites(movieId: Int) {
        let filteredMovieIds = favourtieMoviesIds().filter { $0 != movieId }
        userDefaults.set(filteredMovieIds, forKey: StorageKeys.favouriteMoviesIds)
    }
}
