//
//  NowPlayingViewModel.swift
//  MoviesBrowser
//
//  Created by Aleksander Popko on 08/12/2023.
//

import Foundation

struct NowPlayingViewModel {
    
    private var movieCellViewModels = [MovieCellViewModel]()
    private let storage = Storage()
    
    func numberOfMovieCells() -> Int {
        movieCellViewModels.count
    }
    
    func movieCellViewModelAtRow(_ row: Int) -> MovieCellViewModel? {
        guard movieCellViewModels.count > row else { return nil }
        return movieCellViewModels[row]
    }
    
    func movieIdAtRow(_ row: Int) -> String? {
        guard movieCellViewModels.count > row else { return nil }
        return movieCellViewModels[row].movieId
    }
    
    func setMovieAsFavourite(movieId: String?, isFavourite: Bool) {
        if let movieId = movieId {
            if isFavourite {
                storage.saveMovieAsFavourite(movieId: movieId)
            } else {
                storage.removeMovieFromFavourites(movieId: movieId)            }
        }
        movieCellViewModels.filter({$0.movieId == movieId}).first?.isFavourite = isFavourite
    }
}
