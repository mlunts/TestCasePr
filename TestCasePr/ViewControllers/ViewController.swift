//
//  ViewController.swift
//  TestCasePr
//
//  Created by Marina Lunts on 6/14/19.
//  Copyright © 2019 Marina Lunts. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let service = Service()
    var upcomingMovies = [Movie]() {
        didSet {
           upcomingMoviesTable.reloadData()
        }
    }
    var currentMovies = [Movie]() {
        didSet {
           currentCollectionView.reloadData()
        }
    }
    
    @IBOutlet weak var currentCollectionView: UICollectionView!
    
    @IBOutlet weak var upcomingMoviesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovies()
    }

    private func getMovies() {
        service.fetchMovies(url: UPCOMING_URL) { (movieList, success) in
            self.upcomingMovies = movieList
        }
        service.fetchMovies(url: NOWPLAYING_URL) { (movieList, success) in
            self.currentMovies = movieList
        }
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !currentMovies.isEmpty {
        return 5
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
            return 6
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
