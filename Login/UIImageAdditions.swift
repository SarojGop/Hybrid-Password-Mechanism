//
//  UIImageAdditions.swift
//  Login
//
//  Created by Saroj Gopali on 6/20/19.
//  Copyright © 2019 Saroj Gopali. All rights reserved.
//

import UIKit

extension UIImage {
    var imageHash: String? {
        let imageData = pngData()
        let theHash = imageData?.base64EncodedString()
        return theHash
    }
}
