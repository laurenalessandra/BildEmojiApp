//
//  Alert.swift
//  BildEmojiApp
//
//  Created by Lauren Simon on 4/3/19.
//  Copyright © 2019 Lauren Simon. All rights reserved.
//

import Foundation
import UIKit

class BasicAlert {
    func showAlert(title: String, message: String, action: String, view: ViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: action, style: UIAlertAction.Style.default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
    
}

class TextFieldAlert {
    func showAlert(title: String, message: String, action: String, view: ViewController, completion: @escaping (String)->()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: action, style: UIAlertAction.Style.default) { (_) in
            if let field = alert.textFields?.first?.text {
                completion(field)
                }
            })
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { _ in
            completion("")
            })
        alert.addTextField { textField in
            textField.placeholder = "Enter here"
        }
        view.present(alert, animated: true, completion: nil)
    }
}

