//
//  DetailsViewController.swift
//  TestCasePr
//
//  Created by Marina Lunts on 6/15/19.
//  Copyright © 2019 Marina Lunts. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    public var selectedMovie = Movie()
    private var service = Service()
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagLineLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var genresView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        service.getMovieByID(selectedMovie: selectedMovie) { (movie, true) in
            self.selectedMovie = movie
            print(movie.runtime)
            self.updateUI()
        }
        // Do any additional setup after loading the view.
    }
    
    private func updateUI() {
        genresView.reloadData()
        posterImage.image = selectedMovie.backgrImage
        titleLabel.text = selectedMovie.title
        tagLineLabel.text = selectedMovie.tagLine
        releaseDateLabel.text = selectedMovie.releaseDate.dateToString(format: "MMMM d, YYYY")
        if selectedMovie.averageVote == 0 {
            rateLabel.text = "No votes yet"
        } else {
            rateLabel.text = String(selectedMovie.averageVote)
        }
    }
    

}

extension DetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedMovie.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "genreCell", for: indexPath) as! GenreCollectionViewCell
        cell.genreLabel.text = selectedMovie.genres[indexPath.row]
        
        return cell
    }
    
    
}
