//
//  MovieCellViewModelTests.swift
//  MoviesBrowserTests
//
//  Created by Aleksander Popko on 12/12/2023.
//

import XCTest
@testable import MoviesBrowser

final class MovieCellViewModelTests: XCTestCase {

    // MARK: - Properties
        
        var sut: MovieCellViewModel!
        
        // MARK: - Setup
        
        override func setUp() {
            super.setUp()
            setupSUT()
        }
        
        private func setupSUT() {
            let movie = Movie(title: "The Matrix", movieId: 789)
            sut = MovieCellViewModel(movie: movie, isFavourite: true)
        }
        
        override func tearDown() {
            sut = nil
            super.tearDown()
        }
        
        // MARK: - Tests
        
        func testInitialization() {
            // Then
            XCTAssertEqual(sut.title, "The Matrix")
            XCTAssertEqual(sut.movieId, 789)
            XCTAssertTrue(sut.isFavourite)
        }
    
    func testInitializationWithFalseFavouriteStatus() {
        // Given
        let movie = Movie(title: "Pulp Fiction", movieId: 456)
        
        // When
        let viewModel = MovieCellViewModel(movie: movie, isFavourite: false)
        
        // Then
        XCTAssertEqual(viewModel.title, "Pulp Fiction")
        XCTAssertEqual(viewModel.movieId, 456)
        XCTAssertFalse(viewModel.isFavourite)
    }
    
    func testFavouriteStatusUpdate() {
        // When
        sut.isFavourite = false
        
        // Then
        XCTAssertFalse(sut.isFavourite)
    }

}
