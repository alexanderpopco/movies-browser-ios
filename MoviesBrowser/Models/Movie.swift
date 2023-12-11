//
//  Movie.swift
//  MoviesBrowser
//
//  Created by Aleksander Popko on 06/12/2023.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let title: String
    let movieId: Int
    
    enum CodingKeys: String, CodingKey {
        case title
        case movieId = "id"
    }
}
