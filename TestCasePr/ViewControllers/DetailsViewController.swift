//
//  DetailsViewController.swift
//  TestCasePr
//
//  Created by Marina Lunts on 6/15/19.
//  Copyright © 2019 Marina Lunts. All rights reserved.
//

import UIKit
import SimpleAnimation

class DetailsViewController: UIViewController {

    public var selectedMovie = Movie()
    private var service = Service()
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagLineLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var descrLabel: UILabel!
    @IBOutlet weak var genresView: UICollectionView!
    @IBOutlet weak var fadeBoxView: UIView!
    @IBOutlet weak var detailView: UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialView(check: true)
        service.getMovieByID(selectedMovie: selectedMovie) { (movie, true) in
            self.selectedMovie = movie
            self.updateUI()
            self.fadeBoxView.fadeOut()
        }
        // Do any additional setup after loading the view.
    }
    
    private func initialView(check: Bool) {
        detailView.isHidden = check
        posterImage.isHidden = check
    }
    
    private func updateUI() {
        initialView(check: false)
        
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
        if selectedMovie.overview.isEmpty {
            descrLabel.text = "No information yet"
        } else {
            descrLabel.text = selectedMovie.overview
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
