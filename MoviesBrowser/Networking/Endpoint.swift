//
//  Endpoint.swift
//  MoviesBrowser
//
//  Created by Aleksander Popko on 10/12/2023.
//

import Foundation

private let apiKey = "YOUR_API_KEY"

private struct Queries {
    static let apiQuery = URLQueryItem(name: "api_key", value: apiKey)
    static let languageQuery = URLQueryItem(name: "language", value: "en-US")
}

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
}

extension Endpoint {
    
    static func movieDetails(movieId: Int) -> Endpoint {
        return Endpoint(
            path: "/3/movie/" + String(movieId),
            queryItems: [
                Queries.apiQuery,
                Queries.languageQuery
            ]
        )
    }
    
    static func nowPlayingMovies(page: Int) -> Endpoint {
        return Endpoint(
            path: "/3/movie/now_playing",
            queryItems: [
                Queries.apiQuery,
                Queries.languageQuery,
                URLQueryItem(name: "page", value: String(page))
            ]
        )
    }
}
