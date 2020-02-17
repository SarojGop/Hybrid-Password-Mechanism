//
//  signinusernameViewController.swift
//  Login
//
//  Created by Saroj Gopali on 6/22/19.
//  Copyright © 2019 Saroj Gopali. All rights reserved.
//

import UIKit

class signinusernameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signinButtonPressed(_ sender: UIButton) {
        if let imageAuthVC = storyboard?.instantiateViewController(withIdentifier: "ImageAuth") as? ImageAuthViewController {
            imageAuthVC.isLogin = true
            navigationController?.pushViewController(imageAuthVC, animated: true)
        }
    }

}
