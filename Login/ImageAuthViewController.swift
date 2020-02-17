//
//  imageSignupViewController.swift
//  Login
//
//  Created by Saroj Gopali on 4/25/19.
//  Copyright © 2019 Saroj Gopali. All rights reserved.
//

import UIKit
import Firebase

class ImageAuthViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var authButton: UIButton!
    
    let imagesCount: UInt32 = 30
    var images = [UIImage]()
    var selectedIndexes = [Int]()
    var email: String?
    var password = String()
    var isLogin = false
    var ref: DatabaseReference!
    var numCols: CGFloat = 3
    var padding: CGFloat = 25
        
    

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width - (numCols + 1) * padding) / numCols
        let height = width
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        layout.sectionInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        
        collectionView.collectionViewLayout = layout
        
        fetchImages { (images) in
            self.images = images
            self.collectionView.reloadData()
        }
        if isLogin {
            navigationItem.title = "Sign in Page"
            authButton.setTitle("Login", for: .normal)
        } else {
            navigationItem.title = "Sign up Page"
            authButton.setTitle("Sign Up", for: .normal)
        }
    }
    
    func fetchImages(completion: @escaping (_ images: [UIImage]) -> Void) {
        guard let theEmail = email else {
            completion([])
            return
        }
        if theEmail.isEmpty {
            completion([])
            return
        }
        if !isLogin {
            completion(getRandomImages(count: 9))
            return
        }
        let imagesRef = ref.child(theEmail.replacingOccurrences(of: ".", with: "_DOT_"))
        imagesRef.observeSingleEvent(of: .value) { (snapshot) in
            if let hashes = snapshot.value as? [String] {
                var downloadedImages = hashes.map({ (hash) -> UIImage in
                    let data = Data(base64Encoded: hash)!
                    let image = UIImage(data: data)!
                    return image
                })
                while downloadedImages.count < 9 {
                    let randomNumber = Int(arc4random_uniform(self.imagesCount))
                    if let randomImage = UIImage(named: "\(randomNumber)") {
                        if let imageHash = randomImage.imageHash {
                            if !hashes.contains(imageHash) {
                                downloadedImages.append(randomImage)
                            }
                            
                        }
                    }
                    
                }
                downloadedImages.shuffle()
                completion(downloadedImages)
            }
        }
    }
    
    private func getRandomImages(count: Int) -> [UIImage] {
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
    
    
        @IBAction func authenticate(_ sender: UIButton) {
            
            if let theEmail = email, !password.isEmpty {
                
                //TODO encrypt password here
                
                
                if isLogin {
                    
                    
                    Auth.auth().signIn(withEmail: theEmail, password: password) { (result, error) in
                        if let theError = error {
                            self.showErrorAlertWith(message: theError.localizedDescription, clickCompletion: nil)
                            self.reset()
                        } else {
                            self.showSuccessAlertWith(message: "Successfully logged in") {
                                self.dismiss(animated: true, completion: nil)
                            }
                        }
                    }
                } else {
                    
                    Auth.auth().createUser(withEmail: theEmail, password: password) { (result, error) in
                        if let theError = error {
                            self.showErrorAlertWith(message: theError.localizedDescription, clickCompletion: nil)
                            self.reset()
                        } else {
                            // Save the images
                            let emailRef = self.ref.child(theEmail.replacingOccurrences(of: ".", with: "_DOT_"))
                            var imageHashes = [String]()
                            for i in 0..<self.selectedIndexes.count {
                                let index = self.selectedIndexes[i]
                                let image = self.images[index]
                                imageHashes.append(image.imageHash!)
                            }
                            emailRef.setValue(imageHashes)
//                            let signInviewpage = self.storyboard?.instantiateViewController(withIdentifier: "Home") as! homePageViewController
                            
                            self.showSuccessAlertWith(message: "Successfully logged in") {
                              //  self.present(signInviewpage, animated: true, completion: nil)
                                self.dismiss(animated: true, completion: nil)
                                
                            }
                            
                           
                        }
                    }
                }
                
                
//                let signInviewpage = self.storyboard?.instantiateViewController(withIdentifier: "signInViewController") as! signInViewController
//                self.present(signInviewpage, animated: true, completion: nil)
//
//                print("created")
            }
        }
    
    
    func reset() {
        self.password = ""
        self.selectedIndexes.removeAll()
        self.collectionView.reloadData()
    }
    
    
}
        
        
    


extension ImageAuthViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SignupCell", for: indexPath) as! SignupCell
        let image = images[indexPath.item]
        cell.thumbnail.image = image
        if selectedIndexes.contains(indexPath.item) {
            cell.thumbnail.layer.borderColor = UIColor.black.cgColor
            cell.thumbnail.layer.borderWidth = 2
        } else {
            cell.thumbnail.layer.borderWidth = 0
        }
        return cell
    }
    
    
    func showAlertWithPasswordField(completion: @escaping (_ password: String?, _ cancelled: Bool) -> Void) {
        let alert = UIAlertController(title: "Password", message: "Enter text that you'd like to associate with this image", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            completion(nil, true)
        }
        let enterAction = UIAlertAction(title: "Enter", style: .default) { (action) in
            if let password = alert.textFields?.first?.text, !password.isEmpty {
                completion(password, false)
            } else {
                self.showAlertWithPasswordField(completion: completion)
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(enterAction)
        alert.addTextField { (textField) in
            textField.placeholder = "Password"
        }
        present(alert, animated: true, completion: nil)
    }
    
    

}

extension ImageAuthViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndexes.contains(indexPath.item) {
            return
        }
        showAlertWithPasswordField { (password, cancelled) in
            if !cancelled {
                self.selectedIndexes.append(indexPath.row)
                let image = self.images[indexPath.item]
                if let imageHash = image.imageHash {
                    self.password.append("\(imageHash)\(password!)")
                }
                self.collectionView.reloadData()
            }
        }
    }
    
}
