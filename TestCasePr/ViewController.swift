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
           
        }
    }
    
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

