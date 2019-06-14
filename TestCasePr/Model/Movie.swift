//
//  Movie.swift
//  TestCasePr
//
//  Created by Marina Lunts on 6/14/19.
//  Copyright © 2019 Marina Lunts. All rights reserved.
//

import UIKit

class Movie: NSObject {
    var id : Int
    var title : String
    var adult : Bool
    var overview : String
    var image : URL!
    var releaseDate : Date!
    var averageVote : Double
    
    override init() {
        self.id = 0
        self.title = ""
        self.adult = false
        self.overview = ""
        self.averageVote = 0
    }
    
    public init(id : Int, title : String, adult : String, overview : String, image : String, releaseString : String, averageVote : Double) {
        self.id = id
        self.title = title
        self.adult = adult.toBool()
        self.overview = overview
        self.image = URL(string: "https://image.tmdb.org/t/p/original/\(image)")
        self.releaseDate = releaseString.toDate(format: "YYYY-MM-dd")
        self.averageVote = averageVote
    }
    
    
    
}
