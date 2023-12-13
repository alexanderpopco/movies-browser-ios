//
//  NowPlayingViewModel.swift
//  MoviesBrowser
//
//  Created by Aleksander Popko on 08/12/2023.
//

import Foundation

class NowPlayingMoviesViewModel {
    
    private var nowPlayingMovieCellViewModels = [MovieCellViewModel]()
    private var searchMovieCellViewModels = [MovieCellViewModel]()
    private let storage = Storage.shared
    private let networkManager = NetworkManager.shared
    
    private var currentPage = 0
    private var searchString = ""
    
    func updateSearchString(string: String) {
        searchString = string
    }

    func shouldPresentSearchData() -> Bool {
        return !searchString.isEmpty
    }
    
    func numberOfMovieCells() -> Int {
        return shouldPresentSearchData() ? searchMovieCellViewModels.count : nowPlayingMovieCellViewModels.count
    }
    
    func movieCellViewModelAtRow(_ row: Int) -> MovieCellViewModel? {
        if shouldPresentSearchData() {
            guard searchMovieCellViewModels.count > row else { return nil }
            return searchMovieCellViewModels[row]
        } else {
            guard nowPlayingMovieCellViewModels.count > row else { return nil }
            return nowPlayingMovieCellViewModels[row]
        }
    }
    
    func movieIdAtRow(_ row: Int) -> Int? {
        if shouldPresentSearchData() {
            guard searchMovieCellViewModels.count > row else { return nil }
            return searchMovieCellViewModels[row].movieId
        } else {
            guard nowPlayingMovieCellViewModels.count > row else { return nil }
            return nowPlayingMovieCellViewModels[row].movieId
        }
    }
    
    func setMovieAsFavourite(movieId: Int?, isFavourite: Bool) {
        if let movieId = movieId {
            if isFavourite {
                storage.saveMovieAsFavourite(movieId: movieId)
            } else {
                storage.removeMovieFromFavourites(movieId: movieId)            }
        }
        nowPlayingMovieCellViewModels.filter({$0.movieId == movieId}).first?.isFavourite = isFavourite
    }
    
    func loadNowPlayingMovies(completion: ((Error?) -> Void)?) {
        weak var weakSelf = self
        networkManager.fetchNowPlayingMovies(page: currentPage + 1) { movieResponse, error in
            if let movies: [Movie] = movieResponse?.results {
                let favouriteMoviesIds = weakSelf?.storage.favourtieMoviesIds()
                let newMovieCellViewModels: [MovieCellViewModel] = movies.map { movie in
                    let isFavourite = favouriteMoviesIds?.contains(movie.movieId) ?? false
                    return MovieCellViewModel(movie: movie, isFavourite: isFavourite)
                } as! [MovieCellViewModel]
                weakSelf?.nowPlayingMovieCellViewModels.append(contentsOf: newMovieCellViewModels)
                weakSelf?.currentPage += 1
                completion?(error)
            }
        }
    }
    
    func loadSearchedMovies(completion: ((Error?) -> Void)?) {
        weak var weakSelf = self
        networkManager.fetchSearchedMovies(searchString: searchString, completion: { movieResponse, error in
            if let movies: [Movie] = movieResponse?.results {
                let favouriteMoviesIds = weakSelf?.storage.favourtieMoviesIds()
                let newMovieCellViewModels: [MovieCellViewModel] = movies.map { movie in
                    let isFavourite = favouriteMoviesIds?.contains(movie.movieId) ?? false
                    return MovieCellViewModel(movie: movie, isFavourite: isFavourite)
                } as! [MovieCellViewModel]
                weakSelf?.searchMovieCellViewModels = newMovieCellViewModels
                completion?(error)
            }
        })
    }
}
