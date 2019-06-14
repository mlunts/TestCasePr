//
//  Service.swift
//  TestCasePr
//
//  Created by Marina Lunts on 6/14/19.
//  Copyright © 2019 Marina Lunts. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Service: NSObject {
    
    public func fetchMovies(url: String, completion: @escaping ([Movie] ,Bool) -> Void) {
        var movies = [Movie]()
        let parameters : [String : String] = ["api_key" : API_KEY, "region" : REGION]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                let json : JSON = JSON(response.result.value!)
                for i in 0..<json["results"].count {
                    movies.append(Movie( id: json["results"][i]["id"].intValue, title: json["results"][i]["title"].stringValue, adult: json["results"][i]["adult"].stringValue, overview: json["results"][i]["overview"].stringValue, image: json["results"][i]["poster_path"].stringValue, releaseString: json["results"][i]["release_date"].stringValue, averageVote: json["results"][i]["vote_average"].doubleValue))
                }

                completion(movies,true)
            }
            else {
                print("error")
                completion([],false)
            }
        }
    }
    
}
