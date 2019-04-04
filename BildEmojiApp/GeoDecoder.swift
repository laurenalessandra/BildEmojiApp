//
//  GeoDecoder.swift
//  BildEmojiApp
//
//  Created by Lauren Simon on 4/3/19.
//  Copyright © 2019 Lauren Simon. All rights reserved.
//

import Foundation
import CoreLocation

class GeoDecoder {
    
    func decode(location: CLLocation, completion: @escaping (String)->()) {
        let geoCoder = CLGeocoder()
        var place = ""
        geoCoder.reverseGeocodeLocation(location
            , completionHandler: {
                placemarks, error in
                if placemarks != nil {
                    let placemark = placemarks?.last
                    place = (placemark?.name)!
                    completion(place)
                } else {
                    print("Error retrieving place.  Error code: \(error!)")
                    place = "Unknown Location"
                    completion(place)
                    
                }
        })
    }
}
