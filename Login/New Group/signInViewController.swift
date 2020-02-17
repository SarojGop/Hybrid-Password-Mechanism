//
//  signInViewController.swift
//  Login
//
//  Created by Saroj Gopali on 11/28/18.
//  Copyright © 2018 Saroj Gopali. All rights reserved.
//

import UIKit
import Firebase


var registerView: registerViewController!

class signInViewController: UIViewController {

    @IBOutlet weak var userNameText: UITextField!
    let imagesCount: UInt32 = 30
    @IBOutlet weak var userPasswordText: UITextField!
    var email: String?
    var images = [UIImage]()
    let ref = Database.database().reference()
    
    @IBAction func signInButton(_ sender: UIButton) {
        var registerView: registerViewController!
        let email = userNameText.text , password = userPasswordText.text
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
        if((email?.isEmpty)! || (password?.isEmpty)!)
        {
            print("All Fields are Required")
            displayMessage(userMessage: "All Fields are Required")
            return
          
        }
        let myactivityIndicator = UIActivityIndicatorView (style: UIActivityIndicatorView.Style.gray)
        
        myactivityIndicator.center = view.center
        myactivityIndicator.hidesWhenStopped = false
        myactivityIndicator.startAnimating()
        view.addSubview(myactivityIndicator)
        
        func removeactivityIndicator(activityIndicator: UIActivityIndicatorView){
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview();
            }
        }
        /*
        func checkPassword(logPassword:String){
            logPassword.trimmingCharacters(in: .whitespacesAndNewlines)
            let passwordWithout = logPassword.split(separator: 'user.text')
             let correctPassword = passwordWithout[1]
            password = correctPassword
        }
        
       */
        Auth.auth().signIn(withEmail: email!, password: password!) { (user, error) in
                // [START_EXCLUDE]
                if let error = error {
                   displayMessage(userMessage: error.localizedDescription)
                    removeactivityIndicator(activityIndicator: myactivityIndicator)
                        return
                    }
            
            let homePageView = self.storyboard?.instantiateViewController(withIdentifier: "homePageViewController") as! homePageViewController
            self.present(homePageView, animated: true, completion: nil
            )}
        
    }
    
    
    func fetchImages(completion: @escaping (_ images: [UIImage]) -> Void) {
        guard let theEmail = email else {
            completion([])
            return
        }
        let imagesRef = ref.child(theEmail).child("images")
        imagesRef.observeSingleEvent(of: .value) { (snapshot) in
            if let hashes = snapshot.value as? [String] {
                var images = hashes.map({ (hash) -> UIImage in
                    let data = Data(base64Encoded: hash)!
                    let image = UIImage(data: data)!
                    return image
                })
                while images.count < 9 {
                    let randomNumber = Int(arc4random_uniform(self.imagesCount))
                    if let randomImage = UIImage(named: "\(randomNumber)") {
                        if let imageHash = randomImage.imageHash {
                            if !hashes.contains(imageHash) {
                                images.append(randomImage)
                            }

                        }
                    }
                    
                }
                completion(images)
            }
        }
    }
    
    func getRandomImages(count: Int) -> [UIImage] {
        var numbers = [Int]()
        while numbers.count < count {
            let randomNum = Int(arc4random_uniform(imagesCount))
            if !numbers.contains(randomNum) {
                numbers.append(randomNum)
            }
        }
        return numbers.map({ (n) -> UIImage in
            return UIImage(named: "\(n)")!
        })
    }
    
    
    

    @IBAction func signUpButton(_ sender: UIButton) {
        let registerPage = self.storyboard?.instantiateViewController(withIdentifier: "registerViewController") as! registerViewController
        self.present(registerPage, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImages { (images) in
            self.images = images
//             self.collectionView.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    

}
