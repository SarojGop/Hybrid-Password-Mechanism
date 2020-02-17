//
//  EmailViewController.swift
//  
//
//  Created by Saroj Gopali on 6/22/19.
//

import UIKit

class EmailViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nextButton: UIButton!

    
    var isLogin = false

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = isLogin ? "Sign In" : "Sign Up"
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if emailField.text?.isEmpty == true {
            showAlertWith(title: "Enter Email", message: "Please enter your email to proceed", clickCompletion: nil)
            return
        }
        if let imageAuthVC = storyboard?.instantiateViewController(withIdentifier: "ImageAuth") as? ImageAuthViewController {
            imageAuthVC.isLogin = isLogin
            imageAuthVC.email = emailField.text
            navigationController?.pushViewController(imageAuthVC, animated: true)
        }
    }

}
