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
    private var selectedMovieId: Int?
    var isLoadingList = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        navigationItem.title = NSLocalizedString("Now Playing", comment: "")
        loadMovies()
    }
    
    func loadMovies() {
        weak var weakSelf = self
        isLoadingList = true
        viewModel.loadMovies { error in
            DispatchQueue.main.async {
                if let error = error {
                    weakSelf?.showAlertWithTitle(title: NSLocalizedString("Error", comment: ""), message: error.localizedDescription)
                } else {
                    weakSelf?.tableView.reloadData()
                }
                weakSelf?.isLoadingList = false
            }
        }
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: MovieCell.reuseIdentifier)
    }

    // MARK: Table view datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMovieCells()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell {
            let cellViewModel = viewModel.movieCellViewModelAtRow(indexPath.row)
            cell.configureWithViewModel(viewModel: cellViewModel)
            weak var weakSelf = self
            cell.selectMovieAsFavouriteHandler = { isFavourite in
                DispatchQueue.main.async {
                    weakSelf?.setMovieAsFavourite(movieId: cellViewModel?.movieId, isFavourite: isFavourite)
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
    // MARK: Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMovieId = viewModel.movieIdAtRow(indexPath.row)
        guard selectedMovieId != nil else { return }
        performSegue(withIdentifier: "showMovieDetailsSegue", sender: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !isLoadingList) {
            self.isLoadingList = true
            self.loadMovies()
        }
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == showMovieDetailsSegueIdentifier) {
            if let controller = segue.destination as? MovieDetailsViewController {
                controller.movieId = selectedMovieId
                weak var weakSelf = self
                controller.selectMovieAsFavouriteHandler = { isFavourite in
                    DispatchQueue.main.async {
                        weakSelf?.setMovieAsFavourite(movieId: weakSelf?.selectedMovieId, isFavourite: isFavourite)
                    }
                }
            }
        }
    }
    
    // MARK: Saving as favourite
    
    private func setMovieAsFavourite(movieId: Int?, isFavourite: Bool) {
        viewModel.setMovieAsFavourite(movieId: movieId, isFavourite: isFavourite)
        tableView.reloadData()
    }
}

