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
    let posterUrl: String
    let date: Date
    let rating: String
    let overview: String
    var isFavourite: Bool
    
    init(movieDetails: MovieDetails, isFavourite: Bool) {
        self.title = movieDetails.title
        self.movieId = movieDetails.movieId
        self.posterUrl = movieDetails.posterUrl
        self.date = movieDetails.date
        self.rating = movieDetails.rating
        self.overview = movieDetails.overview
        self.isFavourite = isFavourite
    }
}
