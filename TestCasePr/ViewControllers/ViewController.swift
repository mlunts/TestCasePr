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
    private var selectedMovie = Movie()
    
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
    @IBOutlet weak var viewAllNowPlayingButton: UIButton!
    @IBOutlet weak var viewAllUpcomingButton: UIButton!
    
    
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
        if (segue.identifier == "goToCurrentList") {
            let vc = segue.destination as! MoviesListViewController
            vc.list = currentMovies
            vc.titleView = "Now Playing"
        } else if segue.identifier == "goToComingSoonList" {
            let vc = segue.destination as! MoviesListViewController
            vc.list = upcomingMovies
            vc.titleView = "Coming Soon"
        } else if segue.identifier == "goToDetailsFromExplore" {
            let detailsVC = segue.destination as! DetailsViewController
            detailsVC.selectedMovie = selectedMovie
        }
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !currentMovies.isEmpty {
            return 6
        } else {
            print(currentMovies.count)
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nowMovieCell", for: indexPath) as! MovieCellCollectionViewCell
        if !currentMovies.isEmpty {
            cell.movieTitle.text = currentMovies[indexPath.row].title
            cell.posterImage.image = currentMovies[indexPath.row].image
            cell.rateLabel.text = String(currentMovies[indexPath.row].averageVote)
            viewAllNowPlayingButton.isHidden = false
        } else {
            cell.movieTitle.text = "No movies are playing right now"
            cell.posterImage.image = UIImage(named: "no-image")
            viewAllNowPlayingButton.isHidden = true
            cell.noRating()
        }
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedMovie = currentMovies[indexPath.row]
        performSegue(withIdentifier: "goToDetailsFromExplore", sender: nil)
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !upcomingMovies.isEmpty {
            return 4
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "upcomingCell", for: indexPath) as! UpcomingMoviesTableViewCell
        if !upcomingMovies.isEmpty {
            cell.titleLabel.text = upcomingMovies[indexPath.row].title
            cell.dateLabel.text = upcomingMovies[indexPath.row].releaseDate.dateToString(format: "dd MMM yyyy")
            viewAllUpcomingButton.isHidden = false
        } else {
            cell.titleLabel.text = "No upcoming movies."
            viewAllUpcomingButton.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMovie = upcomingMovies[indexPath.row]
        performSegue(withIdentifier: "goToDetailsFromExplore", sender: nil)
    }
}
