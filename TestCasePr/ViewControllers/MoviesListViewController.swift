//
//  MoviesListViewController.swift
//  TestCasePr
//
//  Created by Marina Lunts on 6/14/19.
//  Copyright © 2019 Marina Lunts. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController {
    
    public var list = [Movie]()
    public var titleView : String!
    private var selectedMovie = Movie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = titleView
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "goToDetailsFromList" {
            let detailsVC = segue.destination as! DetailsViewController
            detailsVC.selectedMovie = selectedMovie
        }
    }
}

extension MoviesListViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieTableCell", for: indexPath) as! MovieTableViewCell
        
        cell.titleLabel.text = list[indexPath.row].title
        if list[indexPath.row].overview.isEmpty {
            cell.infoLabel.text = "No description yet."
        } else {
            cell.infoLabel.text = list[indexPath.row].overview
        }
        
        cell.posterImage.image = list[indexPath.row].image
        if list[indexPath.row].averageVote == 0 {
            cell.rateLabel.text = "No votes yet"
        } else {
            cell.rateLabel.text = String(list[indexPath.row].averageVote)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMovie = list[indexPath.row]
        performSegue(withIdentifier: "goToDetailsFromList", sender: nil)
    }
}
