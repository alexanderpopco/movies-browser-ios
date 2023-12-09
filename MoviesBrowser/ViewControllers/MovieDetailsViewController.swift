//
//  MovieDetailsViewController.swift
//  MoviesBrowser
//
//  Created by Aleksander Popko on 06/12/2023.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateOfReleaseLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var isFavouriteButton: UIBarButtonItem!
    
    var movieId: String?
    var selectMovieAsFavouriteHandler: ((Bool)->())?
    
    private var viewModel: MovieDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupViewModel(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        configureLabels()
        configurePosterImageView()
        configureIsFavouriteButton()
    }
    
    private func configureLabels() {
        titleLabel.text = viewModel?.title
        dateOfReleaseLabel.text = viewModel?.releaseDate
        ratingLabel.text = viewModel?.rating
        overviewLabel.text = viewModel?.overview
    }
    
    private func configurePosterImageView() {
        if let url = viewModel?.posterUrl {
            posterImageView.load(url: url)
        }
    }
    
    private func configureIsFavouriteButton() {
        if let viewModel = viewModel {
            isFavouriteButton.image = viewModel.isFavourite ? UIImage.starFilledImage() : UIImage.starEmptyImage()
        }
    }
    
     @IBAction func didTapIsFavouriteButton(_ sender: Any) {
        if let viewModel = viewModel {
            selectMovieAsFavouriteHandler?(!viewModel.isFavourite)
            self.viewModel?.isFavourite = !viewModel.isFavourite
            configureIsFavouriteButton()
        }
    }
}
