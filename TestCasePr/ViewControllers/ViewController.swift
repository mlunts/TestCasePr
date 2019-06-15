//
//  ViewController.swift
//  TestCasePr
//
//  Created by Marina Lunts on 6/14/19.
//  Copyright © 2019 Marina Lunts. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let service = Service()
    private var upcomingMovies = [Movie]() {
        didSet {
            upcomingMoviesTable.reloadData()
        }
    }
    
    private var currentMovies = [Movie]() {
        didSet {
            currentCollectionView.reloadData()
            activityIndicator.stopAnimating()
            allHidden(check: false)
        }
    }
    
    @IBOutlet weak var exploreView: UIView!
    @IBOutlet weak var currentCollectionView: UICollectionView!
    @IBOutlet weak var upcomingMoviesTable: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialView()
        getMovies()
    }
    
    private func setInitialView() {
        activityIndicator.startAnimating()
        allHidden(check: true)
    }
    
    private func allHidden(check: Bool) {
        exploreView.isHidden = check
    }
    
    private func getMovies() {
        service.fetchMovies(url: UPCOMING_URL) { (movieList, success) in
            self.upcomingMovies = movieList
        }
        service.fetchMovies(url: NOWPLAYING_URL) { (movieList, success) in
            self.currentMovies = movieList
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! MoviesListViewController
        if (segue.identifier == "goToCurrentList") {
            vc.list = currentMovies
            vc.titleView = "Now Playing"
        } else if segue.identifier == "goToComingSoonList" {
            vc.list = upcomingMovies
            vc.titleView = "Coming Soon"
        }
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !currentMovies.isEmpty {
            return 6
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nowMovieCell", for: indexPath) as! MovieCellCollectionViewCell
        cell.movieTitle.text = currentMovies[indexPath.row].title
        cell.posterImage.image = currentMovies[indexPath.row].image
        cell.rateLabel.text = String(currentMovies[indexPath.row].averageVote)
        return cell
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !upcomingMovies.isEmpty {
            return 4
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "upcomingCell", for: indexPath) as! UpcomingMoviesTableViewCell
        cell.titleLabel.text = upcomingMovies[indexPath.row].title
        cell.dateLabel.text = upcomingMovies[indexPath.row].releaseDate.dateToString(format: "dd MMM yyyy")
        return cell
    }
}
