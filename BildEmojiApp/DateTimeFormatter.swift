//
//  DateTimeFormatter.swift
//  BildEmojiApp
//
//  Created by Lauren Simon on 4/4/19.
//  Copyright © 2019 Lauren Simon. All rights reserved.
//

import Foundation

class DateTimeFormatter {
    
    func formatDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy:MM:dd HH:mm:ss"
        let newDate = dateFormatter.date(from: date)
        
        let stringFormatter = DateFormatter()
        stringFormatter.dateFormat = "dd MMM, yyyy HH:mm"
        return stringFormatter.string(from: newDate!)
    }
    
}
