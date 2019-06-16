//
//  File.swift
//  TestCasePr
//
//  Created by Marina Lunts on 6/16/19.
//  Copyright © 2019 Marina Lunts. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    func showAlert(titleText: String, messageText: String) -> UIAlertController {
        let alert: UIAlertController = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(okAction)
        return alert
    }
}
