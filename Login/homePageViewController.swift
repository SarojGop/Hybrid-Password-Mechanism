//
//  homePageViewController.swift
//  Login
//
//  Created by Saroj Gopali on 11/6/18.
//  Copyright © 2018 Saroj Gopali. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

//var ref: DatabaseReference!
class homePageViewController: UIViewController{
    
    var databaseref: DatabaseReference?
    var databasehaldle: DatabaseHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser == nil {
            if let welcomeVC = storyboard?.instantiateViewController(withIdentifier: "Welcome") {
                present(UINavigationController(rootViewController: welcomeVC),
                        animated: true,
                        completion: nil)
            }
        }
    }
    
    
    @IBAction func signoutButton(_ sender: Any) {
        
        do {
           
            try Auth.auth().signOut()
            
            if let welcomeVC = storyboard?.instantiateViewController(withIdentifier: "Welcome") {
                present(UINavigationController(rootViewController: welcomeVC),
                        animated: true,
                        completion: nil)
            }

        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
   
    

    @IBAction func viewButton(_ sender: Any) {
      
    }
    
   
    

    

}
