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
        var formattedDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy:MM:dd HH:mm:ss"
        if let newDate = dateFormatter.date(from: date) {
            let stringFormatter = DateFormatter()
            stringFormatter.dateFormat = "dd MMM, yyyy HH:mm"
            formattedDate = stringFormatter.string(from: newDate)
        }
        return formattedDate
    }
    
}
