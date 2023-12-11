//
//  MovieDetails.swift
//  MoviesBrowser
//
//  Created by Aleksander Popko on 06/12/2023.
//

import Foundation

struct MovieDetails: Codable {
    let title: String
    let movieId: Int
    let posterPath: String
    let releaseDate: String
    let rating: Double
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case title, overview
        case releaseDate = "release_date"
        case movieId = "id"
        case posterPath = "poster_path"
        case rating = "vote_average"
    }
}
