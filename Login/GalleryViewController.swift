////
////  GalleryViewController.swift
////  Login
////
////  Created by Saroj Gopali on 3/25/19.
////  Copyright © 2019 Saroj Gopali. All rights reserved.
////
//
//import UIKit
//
//class GalleryViewController: UIViewController {
//    private var searches: [FlickrSearchResults] = []
//    private let flickr = Flickr()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // MARK: - Text Field Delegate
//        
//            
//
//        // Do any additional setup after loading the view.
//    }
//    
//    private extension FlickrPhotosViewController {
//        func photo(for indexPath: IndexPath) -> FlickrPhoto {
//            return searches[indexPath.section].searchResults[indexPath.row]
//        }
//        
//    }
//    extension FlickrPhotosViewController : UITextFieldDelegate {
//        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//            // 1
//            let activityIndicator = UIActivityIndicatorView(style: .gray)
//            textField.addSubview(activityIndicator)
//            activityIndicator.frame = textField.bounds
//            activityIndicator.startAnimating()
//            
//            flickr.searchFlickr(for: textField.text!) { searchResults in
//                activityIndicator.removeFromSuperview()
//                
//                switch searchResults {
//                case .error(let error) :
//                    // 2
//                    print("Error Searching: \(error)")
//                case .results(let results):
//                    // 3
//                    print("Found \(results.searchResults.count) matching \(results.searchTerm)")
//                    self.searches.insert(results, at: 0)
//                    // 4
//                    self.collectionView?.reloadData()
//                }
//            }
//            
//            textField.text = nil
//            textField.resignFirstResponder()
//            return true
//        }
//    }
//    extension FlickrPhotosViewController {
//        //1
//        override func numberOfSections(in collectionView: UICollectionView) -> Int {
//            return searches.count
//        }
//        
//        //2
//        override func collectionView(_ collectionView: UICollectionView,
//                                     numberOfItemsInSection section: Int) -> Int {
//            return searches[section].searchResults.count
//        }
//        
//        //3
//        override func collectionView(
//            _ collectionView: UICollectionView,
//            cellForItemAt indexPath: IndexPath
//            ) -> UICollectionViewCell {
//            let cell = collectionView
//                .dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
//            cell.backgroundColor = .black
//            // Configure the cell
//            return cell
//        }
//    }
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
