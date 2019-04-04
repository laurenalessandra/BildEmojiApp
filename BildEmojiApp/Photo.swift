//
//  Photo.swift
//  BildEmojiApp
//
//  Created by Lauren Simon on 4/3/19.
//  Copyright © 2019 Lauren Simon. All rights reserved.
//

import Foundation
import UIKit

class Photo {
    var photo: UIImage
    var location: String
    var date: String
    
    init(photo: UIImage, location: String, date: String) {
        self.photo = photo
        self.location = location
        self.date = date
    }
}
