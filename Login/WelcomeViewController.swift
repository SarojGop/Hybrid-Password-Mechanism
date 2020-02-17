//
//  WelcomeViewController.swift
//  Login
//
//  Created by Saroj Gopali on 6/22/19.
//  Copyright © 2019 Saroj Gopali. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        showEmailVC(isLogin: false)
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        showEmailVC(isLogin: true)
    }
    
    
    func showEmailVC(isLogin: Bool) {
        if let emailVC = storyboard?.instantiateViewController(withIdentifier: "Email") as? EmailViewController {
            emailVC.isLogin = isLogin
            navigationController?.pushViewController(emailVC, animated: true)
        }
    }

}
