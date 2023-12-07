//
//  MovieDetailsViewModel.swift
//  MoviesBrowser
//
//  Created by Aleksander Popko on 06/12/2023.
//

import Foundation

struct MovieDetailsViewModel {
    let title: String
    let movieId: String
    let posterUrl: URL?
    let releaseDate: String
    let rating: String
    let overview: String
    var isFavourite: Bool
    
    init(movieDetails: MovieDetails, isFavourite: Bool) {
        self.title = movieDetails.title
        self.movieId = movieDetails.movieId
        self.posterUrl = URL(string: movieDetails.posterUrl)
        self.releaseDate = NSLocalizedString("Release date: ", comment: "") + movieDetails.releaseDate.toString()
        self.rating = NSLocalizedString("Rating: ", comment: "") + movieDetails.rating
        self.overview = movieDetails.overview
        self.isFavourite = isFavourite
    }
}
