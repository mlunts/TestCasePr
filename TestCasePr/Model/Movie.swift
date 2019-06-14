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
    var image : UIImage!
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
       
        self.releaseDate = releaseString.toDate(format: "YYYY-MM-dd")
        self.averageVote = averageVote
        super.init()
         self.image = getImageFromURL(url: "https://image.tmdb.org/t/p/original/\(image)")
    }
    
    private func getImageFromURL(url: String) -> UIImage {
        let url = URL(string: url)!
        let data = try? Data(contentsOf: url)

        guard let imageData = data else {
            return UIImage(named: "no-image.jpg")!
        }
        let image = UIImage(data: imageData)!
        return image
    }
    
}
