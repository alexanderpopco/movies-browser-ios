//
//  MovieDetails.swift
//  MoviesBrowser
//
//  Created by Aleksander Popko on 06/12/2023.
//

import Foundation

struct MovieDetails: Codable {
    let title: String
    let movieId: String
    let posterUrl: String
    let releaseDate: Date
    let rating: String
    let overview: String
}
