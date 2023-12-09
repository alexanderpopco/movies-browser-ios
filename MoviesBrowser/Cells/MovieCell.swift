//
//  MovieCell.swift
//  MoviesBrowser
//
//  Created by Aleksander Popko on 09/12/2023.
//

import UIKit

class MovieCell: UITableViewCell {
    
    static let reuseIdentifier = "movieCell"

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var isFavouriteButton: UIButton!
    
    var viewModel: MovieCellViewModel?
    var selectMovieAsFavouriteHandler: ((Bool)->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        isFavouriteButton.imageView?.contentMode = .scaleAspectFit
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureWithViewModel(viewModel: MovieCellViewModel?) {
        self.viewModel = viewModel
        movieTitleLabel.text = viewModel?.title
        configureIsFavouriteButton()
    }
    
    private func configureIsFavouriteButton() {
        if let viewModel = viewModel {
            isFavouriteButton.imageView?.image = viewModel.isFavourite ? UIImage.starFilledImage() : UIImage.starEmptyImage()
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
