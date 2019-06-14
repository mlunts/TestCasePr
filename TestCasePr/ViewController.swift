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
           
        }
    }
    var currentMovies = [Movie]() {
        didSet {
           currentCollectionView.reloadData()
        }
    }
    
    @IBOutlet weak var currentCollectionView: UICollectionView!
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nowMovieCell", for: indexPath) as! MovieCell
        cell.movieTitle.text = currentMovies[indexPath.row].title
        cell.posterImage.image = currentMovies[indexPath.row].image
        return cell
    }
}

class MovieCell : UICollectionViewCell {
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
}
