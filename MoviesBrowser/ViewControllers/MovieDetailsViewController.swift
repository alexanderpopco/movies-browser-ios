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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupViewModel(viewModel: MovieDetailsViewModel) {
        if let url = viewModel.posterUrl {
            posterImageView.load(url: url)
        }
        titleLabel.text = viewModel.title
        dateOfReleaseLabel.text = viewModel.releaseDate
        ratingLabel.text = viewModel.rating
        overviewLabel.text = viewModel.overview
    }
}
