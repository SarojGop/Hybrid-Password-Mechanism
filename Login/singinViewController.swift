//
//  singinViewController.swift
//  Login
//
//  Created by Saroj Gopali on 11/6/18.
//  Copyright © 2018 Saroj Gopali. All rights reserved.
//

import UIKit
import Firebase


class singinViewController: UIViewController {
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    //SignIn button function
    @IBAction func siginButton(_ sender: Any) {
        print("Sigin Button")
        let userName = self.userNameText.text
        let userPass =  self.userPassword.text
        func displayMessage(userMessage: String) -> Void{
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
                
                let ok = UIAlertAction (title: "OK", style: .default, handler: { (action:UIAlertAction) in
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }})
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        if((userName?.isEmpty)!||(userPass?.isEmpty)!)
        {
            print("User Id\(String(describing: userName))or Password\(String(describing: userPass)) is Empty")
            displayMessage(userMessage: "All Fields are Required")
            return
        }
        if ( userName == "" && userPass == "")
        {
          displayMessage(userMessage: "User Name and Password Should Not be Empty")
        }
        
        Auth.auth().signIn(withEmail: userName!, password: userPass!) { (user, Error) in
            if let error = Error {
                displayMessage(userMessage: error.localizedDescription)
                return
            }
           let homepageView = self.storyboard?.instantiateViewController(withIdentifier: "homePageViewController") as! homePageViewController
            self.present(homepageView, animated: true, completion: nil)
        }
        
        
    }
    //Sign Up for new user button call register View Controller page
    @IBAction func signupNew(_ sender: Any) {
       print("Sign Up")
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "registerViewController") as! registerViewController
        self.present(registerViewController, animated:true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        }
        // Do any additional setup after loading the view.
    }
    


