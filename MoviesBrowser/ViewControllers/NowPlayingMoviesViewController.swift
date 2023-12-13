//
//  ViewController.swift
//  MoviesBrowser
//
//  Created by Aleksander Popko on 06/12/2023.
//

import UIKit

private let showMovieDetailsSegueIdentifier = "showMovieDetailsSegue"

class NowPlayingMoviesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    private var viewModel = NowPlayingMoviesViewModel()
    private var selectedMovieId: Int?
    private var isLoadingNowPlayingMovies = false
    
    // MARK: View controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchTextField()
        navigationItem.title = NSLocalizedString("Now Playing", comment: "")
        loadNowPlayingMovies()
    }
    
    // MARK: Setup UI
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: MovieCell.reuseIdentifier)
    }
    
    private func setupSearchTextField() {
        searchTextField.delegate = self
        searchTextField.placeholder = NSLocalizedString("Search", comment: "")
        searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    // MARK: Load data
    
    private func loadNowPlayingMovies() {
        weak var weakSelf = self
        isLoadingNowPlayingMovies = true
        viewModel.loadNowPlayingMovies { error in
            DispatchQueue.main.async {
                if let error = error {
                    weakSelf?.showAlertWithTitle(title: NSLocalizedString("Error", comment: ""), message: error.localizedDescription)
                } else {
                    weakSelf?.tableView.reloadData()
                }
                weakSelf?.isLoadingNowPlayingMovies = false
            }
        }
    }
    
    private func loadSearchedMovies() {
        weak var weakSelf = self
        viewModel.loadSearchedMovies { error in
            DispatchQueue.main.async {
                if let error = error {
                    weakSelf?.showAlertWithTitle(title: NSLocalizedString("Error", comment: ""), message: error.localizedDescription)
                } else {
                    weakSelf?.tableView.reloadData()
                }
            }
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
    
    // MARK: User actions
    
    private func setMovieAsFavourite(movieId: Int?, isFavourite: Bool) {
        viewModel.setMovieAsFavourite(movieId: movieId, isFavourite: isFavourite)
        tableView.reloadData()
    }
}

extension NowPlayingMoviesViewController: UITableViewDataSource {
    
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
    
}

extension NowPlayingMoviesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMovieId = viewModel.movieIdAtRow(indexPath.row)
        guard selectedMovieId != nil else { return }
        performSegue(withIdentifier: "showMovieDetailsSegue", sender: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !viewModel.shouldPresentSearchData() else { return }
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !isLoadingNowPlayingMovies) {            self.isLoadingNowPlayingMovies = true
            self.loadNowPlayingMovies()
        }
    }
    
}

extension NowPlayingMoviesViewController: UITextFieldDelegate {
            
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @objc func textFieldDidChange() {
        viewModel.updateSearchString(string: searchTextField.text ?? "")
        self.loadSearchedMovies()
    }
}
