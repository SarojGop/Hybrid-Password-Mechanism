//
//  registerViewController.swift
//  Login
//
//  Created by Saroj Gopali on 11/6/18.
//  Copyright © 2018 Saroj Gopali. All rights reserved.
//

import UIKit
import Firebase

let ref = Database.database().reference()

class registerViewController: UIViewController {

    @IBOutlet weak var userNameR: UITextField!
    @IBOutlet weak var passwordRe: UITextField!
    @IBOutlet weak var repeatPasswordRe: UITextField!
    
    @IBOutlet weak var especialChar: UITextField!
    
    @IBAction func signUpRe(_ sender: Any) {
        let userName = self.userNameR.text, userPassword = self.passwordRe.text, userRpassword = self.repeatPasswordRe.text, userEspecialchar = self.especialChar.text
        
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
        
        if((userName?.isEmpty)! ||
            (userPassword?.isEmpty)! || (userRpassword?.isEmpty)! || (userEspecialchar?.isEmpty)!)
        {
            print("All Fields are Required")
            displayMessage(userMessage: "All Fields are Required")
            return
        }/*
        let splitPassword = userPassword?.split(separator: " ")
        let splitRePasswrod = userRpassword?.split(separator: " ")
        userPassword = splitPassword[1]
        userRpassword = splitRePasswrod[1]
        if((userPassword?.elementsEqual(userRpassword!))! != true)
        {
            print("Password didn't Match")
            displayMessage(userMessage: "Password should be Match")
            return
        }*/
        
        //function for random text
        func randomAlphaNumericString(length : Int) -> String {
            var characters = Array(48...57).map {String(UnicodeScalar($0))}
            characters.append(contentsOf: (Array(65...90).map {String(UnicodeScalar($0))}))
            characters.append(contentsOf: (Array(97...122).map {String(UnicodeScalar($0))}))
            var randomString = String(length)
            
            for _ in 1..<length {
                let length = UInt32(characters.count)
                let randonIndex = Int(arc4random_uniform(length))
                randomString += characters[randonIndex]
            }
            return randomString
        }
        /* function for random text
        func randomAlphaNumericString(length: Int) -> String {
            let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let allowedCharsCount = UInt32(allowedChars.count)
            var randomString = " "
            
            for _ in 0..<length {
                let randomNum = Int(arc4random_uniform(allowedCharsCount))
                let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)
                let newCharacter = allowedChars[randomIndex]
                randomString += String(newCharacter)
            }
         return randomString
         }*/
        
        
/*
         // check passsword and add random text
        var randPassword = ""
        if((userPassword!.elementsEqual(userRpassword!)) == true){
            let randomPassword = "\(randomAlphaNumericString(length: 5)) \(String(describing: userEspecialchar))\(String(describing: userPassword))\(String(describing: userEspecialchar))\(randomAlphaNumericString(length: 5))"
            randPassword = String(randomPassword)
        }
       */
        
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
        
        
        func displayMessageNext(userMessage: String) -> Void{
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Successfully Register", message: userMessage, preferredStyle: .alert)
                
                let ok = UIAlertAction (title: "OK", style: .default, handler: { (action:UIAlertAction) in
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }})
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        //path for datebase to store password
        
       // let ref = Database.database().reference(withPath: "randPassword")
        
        // displayMessageNext(userMessage: "The User Name and Password has registered.")
        Auth.auth().createUser(withEmail: userName!, password: userPassword!) { (AuthDataResult, Error) in
            //removeactivityIndicator(activityIndicator: myactivityIndicator)
            
            //displayMessageNext(userMessage: "The User Name and Password has registered.")
            guard (AuthDataResult?.user) != nil else{return}
            };
        
        
        let signInviewpage = self.storyboard?.instantiateViewController(withIdentifier: "signInViewController") as! signInViewController
        self.present(signInviewpage, animated: true, completion: nil)
       
        print("created")
    }


    
    @IBAction func cancelRe(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        }

        // Do any additional setup after loading the view.
    }
    


