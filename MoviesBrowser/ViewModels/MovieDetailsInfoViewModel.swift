//
//  MovieDetailsInfoViewModel.swift
//  MoviesBrowser
//
//  Created by Aleksander Popko on 11/12/2023.
//

import Foundation

class MovieDetailsInfoViewModel {
    let title: String
    let movieId: Int
    let posterUrl: URL?
    let releaseDate: String
    let rating: String
    let overview: String
    var isFavourite: Bool
    
    init(movieDetails: MovieDetails, isFavourite: Bool) {
        self.title = movieDetails.title
        self.movieId = movieDetails.movieId
        self.posterUrl = MovieDetailsInfoViewModel.posterUrlFromPath(posterPath: movieDetails.posterPath)
        self.releaseDate = NSLocalizedString("Release date: ", comment: "") + movieDetails.releaseDate
        self.rating = NSLocalizedString("Rating: ", comment: "") + String(movieDetails.rating)
        self.overview = movieDetails.overview
        self.isFavourite = isFavourite
    }
    
    static func posterUrlFromPath(posterPath: String) -> URL? {
            return URL(string: ("https://image.tmdb.org/t/p/w200/" + posterPath))
    }
}
