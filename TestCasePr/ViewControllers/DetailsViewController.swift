//
//  DetailsViewController.swift
//  TestCasePr
//
//  Created by Marina Lunts on 6/15/19.
//  Copyright © 2019 Marina Lunts. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var selectedMovie = Movie()
    
    @IBOutlet weak var posterImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
updateUI()
        // Do any additional setup after loading the view.
    }
    
    private func updateUI() {
        posterImage.image = selectedMovie.image
        navigationItem.title = selectedMovie.title
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
