//
//  MovieDetailsInfoViewModelTests.swift
//  MoviesBrowserTests
//
//  Created by Aleksander Popko on 12/12/2023.
//

import XCTest
@testable import MoviesBrowser

final class MovieDetailsInfoViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var sut: MovieDetailsInfoViewModel!
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        setupSUT()
    }
    
    private func setupSUT() {
        let movieDetails = MovieDetails(
            title: "Inception",
            movieId: 123,
            posterPath: "/abc.jpg",
            releaseDate: "2023-01-01",
            rating: 8.5,
            overview: "A mind-bending movie."
        )
        sut = MovieDetailsInfoViewModel(movieDetails: movieDetails, isFavourite: true)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func testInitialization() {
        // Then
        XCTAssertEqual(sut.title, "Inception")
        XCTAssertEqual(sut.movieId, 123)
        XCTAssertEqual(sut.posterUrl, URL(string: "https://image.tmdb.org/t/p/w300/abc.jpg"))
        XCTAssertEqual(sut.releaseDate, "Release date: 2023-01-01")
        XCTAssertEqual(sut.rating, "Rating: 8.5")
        XCTAssertEqual(sut.overview, "A mind-bending movie.")
        XCTAssertTrue(sut.isFavourite)
    }
    
    func testPosterUrlFromPath() {
        // Given
        let posterPath = "/xyz.jpg"
        
        // When
        let url = MovieDetailsInfoViewModel.posterUrlFromPath(posterPath: posterPath)
        
        // Then
        XCTAssertEqual(url, URL(string: "https://image.tmdb.org/t/p/w300/xyz.jpg"))
    }
}
