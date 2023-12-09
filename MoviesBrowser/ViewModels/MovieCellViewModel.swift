//
//  MovieViewModel.swift
//  MoviesBrowser
//
//  Created by Aleksander Popko on 06/12/2023.
//

import Foundation

class MovieCellViewModel {
    let title: String
    let movieId: String
    var isFavourite: Bool
    
    init(movie: Movie, isFavourite: Bool) {
        self.title = movie.title
        self.movieId = movie.movieId
        self.isFavourite = isFavourite
    }
}
