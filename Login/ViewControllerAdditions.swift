//
//  ViewControllerAdditions.swift
//  Login
//
//  Created by Saroj Gopali on 6/22/19.
//  Copyright © 2019 Saroj Gopali. All rights reserved.
//

import UIKit

extension UIViewController {

    func showAlertWith(title: String?, message: String?, clickCompletion: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            clickCompletion?()
        }
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showErrorAlertWith(message: String?, clickCompletion: (() -> Void)?) {
        showAlertWith(title: "Error", message: message, clickCompletion: clickCompletion)
    }
    
    func showSuccessAlertWith(message: String?, clickCompletion: (() -> Void)?) {
        showAlertWith(title: "Success!", message: message, clickCompletion: clickCompletion)
    }

}
