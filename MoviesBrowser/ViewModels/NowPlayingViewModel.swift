//
//  NowPlayingViewModel.swift
//  MoviesBrowser
//
//  Created by Aleksander Popko on 08/12/2023.
//

import Foundation

class NowPlayingViewModel {
    
    private var movieCellViewModels = [MovieCellViewModel]()
    private let storage = Storage()
    private let networkManager = NetworkManager.shared
    
    func numberOfMovieCells() -> Int {
        movieCellViewModels.count
    }
    
    func movieCellViewModelAtRow(_ row: Int) -> MovieCellViewModel? {
        guard movieCellViewModels.count > row else { return nil }
        return movieCellViewModels[row]
    }
    
    func movieIdAtRow(_ row: Int) -> Int? {
        guard movieCellViewModels.count > row else { return nil }
        return movieCellViewModels[row].movieId
    }
    
    func setMovieAsFavourite(movieId: Int?, isFavourite: Bool) {
        if let movieId = movieId {
            if isFavourite {
                storage.saveMovieAsFavourite(movieId: movieId)
            } else {
                storage.removeMovieFromFavourites(movieId: movieId)            }
        }
        movieCellViewModels.filter({$0.movieId == movieId}).first?.isFavourite = isFavourite
    }
    
    func loadMoviesForPage(page: Int, completion: ((Error?) -> Void)?) {
        weak var weakSelf = self
        networkManager.fetchNowPlayingMovies(page: page) { movieResponse, error in
            if let movies: [Movie] = movieResponse?.results {
                let favouriteMoviesIds = weakSelf?.storage.favourtieMoviesIds() ?? [Int]()
                let newMovieCellViewModels: [MovieCellViewModel] = movies.map { movie in
                    let isFavourite = favouriteMoviesIds.contains(movie.movieId)
                    return MovieCellViewModel(movie: movie, isFavourite: isFavourite)
                } as! [MovieCellViewModel]
                weakSelf?.movieCellViewModels.append(contentsOf: newMovieCellViewModels)
                completion?(error)
            }
        }
    }
}
