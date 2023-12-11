//
//  MovieDetailsViewModel.swift
//  MoviesBrowser
//
//  Created by Aleksander Popko on 06/12/2023.
//

import Foundation

class MovieDetailsViewModel {
    let networkManager = NetworkManager.shared
    let storage = Storage.shared
    var infoViewModel: MovieDetailsInfoViewModel?
    
    func loadMovieDetailsInfo(movieId: Int, completion: ((Error?) -> Void)?) {
        weak var weakSelf = self
        networkManager.fetchMovieDetails(movieId: movieId, completion: { movieDetails, error in
            if let movieDetails: MovieDetails = movieDetails {
                let favouriteMoviesIds = weakSelf?.storage.favourtieMoviesIds()
                let isFavourite = favouriteMoviesIds?.contains(movieId) ?? false
                weakSelf?.infoViewModel = MovieDetailsInfoViewModel(movieDetails: movieDetails, isFavourite: isFavourite)
                completion?(error)
            }
        })
    }
    
}
