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
    
    var movieId: Int?
    var selectMovieAsFavouriteHandler: ((Bool)->())?
    
    private var viewModel = MovieDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovieDetailsInfo()
    }
    
    private func loadMovieDetailsInfo() {
        weak var weakSelf = self
        guard movieId != nil else { return }
        viewModel.loadMovieDetailsInfo(movieId: movieId!, completion: { error in
            DispatchQueue.main.async {
                if let error = error {
                    weakSelf?.showAlertWithTitle(title: NSLocalizedString("Error", comment: ""), message: error.localizedDescription)
                } else {
                    weakSelf?.configureUI()
                }
            }
        })
    }
    
    private func configureUI() {
        configureLabels()
        configurePosterImageView()
        configureIsFavouriteButton()
    }
    
    private func configureLabels() {
        titleLabel.text = viewModel.infoViewModel?.title
        dateOfReleaseLabel.text = viewModel.infoViewModel?.releaseDate
        ratingLabel.text = viewModel.infoViewModel?.rating
        overviewLabel.text = viewModel.infoViewModel?.overview
    }
    
    private func configurePosterImageView() {
        if let url = viewModel.infoViewModel?.posterUrl {
            posterImageView.load(url: url)
        }
    }
    
    private func configureIsFavouriteButton() {
        if let infoViewModel = viewModel.infoViewModel {
            isFavouriteButton.image = infoViewModel.isFavourite ? UIImage.starFilledImage() : UIImage.starEmptyImage()
        }
    }
    
     @IBAction func didTapIsFavouriteButton(_ sender: Any) {
         if let infoViewModel = viewModel.infoViewModel {
            selectMovieAsFavouriteHandler?(!infoViewModel.isFavourite)
             infoViewModel.isFavourite = !infoViewModel.isFavourite
            configureIsFavouriteButton()
        }
    }
}
