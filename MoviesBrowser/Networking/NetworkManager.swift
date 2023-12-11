//
//  NetworkManager.swift
//  MoviesBrowser
//
//  Created by Aleksander Popko on 10/12/2023.
//

import Foundation

private enum NetworkError: Error {
    case invalidUrl
    case invalidData
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    public func fetchMovieDetails(movieId: Int, completion: ((MovieDetails?, Error?) -> Void)?) {
        guard let request = createRequest(for: Endpoint.movieDetails(movieId: movieId)) else {
            completion?(nil, NetworkError.invalidUrl)
            return
        }
        executeRequest(request: request, completion: completion)
    }

    public func fetchNowPlayingMovies(page: Int, completion: ((MovieResponse?, Error?) -> Void)?) {
        guard let request = createRequest(for: Endpoint.nowPlayingMovies(page: page)) else {
            completion?(nil, NetworkError.invalidUrl)
            return
        }
        executeRequest(request: request, completion: completion)
    }
    
    private func createRequest(for endpoint: Endpoint) -> URLRequest? {
        if let url = endpoint.url {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json, charset=utf-8", forHTTPHeaderField: "Content-Type")
            return request
        }
        return nil
    }
    
    private func executeRequest<T: Codable>(request: URLRequest, completion: ((T?, Error?) -> Void)?) {
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completion?(nil, error)
                return
            }
            if let decodedResponse = try? JSONDecoder().decode(T.self, from: data) {
                DispatchQueue.main.async {
                    completion?(decodedResponse, nil)
                }
            } else {
                completion?(nil, NetworkError.invalidData)
            }
        }
        dataTask.resume()
    }
}
