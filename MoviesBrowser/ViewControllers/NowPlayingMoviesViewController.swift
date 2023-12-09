//
//  ViewController.swift
//  MoviesBrowser
//
//  Created by Aleksander Popko on 06/12/2023.
//

import UIKit

private let showMovieDetailsSegueIdentifier = "showMovieDetailsSegue"

class NowPlayingMoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = NowPlayingViewModel()
    private var selectedMovieId: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = NSLocalizedString("Now Playing", comment: "")
    }

    // MARK: Table view datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMovieCells()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseIdentifier, for: indexPath)
        return cell
    
    }
    
    // MARK: Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMovieId = viewModel.movieIdAtRow(indexPath.row)
        guard selectedMovieId != nil else { return }
        performSegue(withIdentifier: "showMovieDetailsSegue", sender: nil)
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == showMovieDetailsSegueIdentifier) {
            if let controller = segue.destination as? MovieDetailsViewController {
                controller.movieId = selectedMovieId
                weak var weakSelf = self
                controller.selectMovieAsFavouriteHandler = { isFavourite in
                    weakSelf?.setMovieAsFavourite(movieId: weakSelf?.selectedMovieId, isFavourite: isFavourite)
                }
            }
        }
    }
    
    // MARK: Saving as favourite
    
    private func setMovieAsFavourite(movieId: String?, isFavourite: Bool) {
        viewModel.setMovieAsFavourite(movieId: movieId, isFavourite: isFavourite)
        tableView.reloadData()
    }
}

