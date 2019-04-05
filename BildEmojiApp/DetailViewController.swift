//
//  DetailViewController.swift
//  BildEmojiApp
//
//  Created by Lauren Simon on 4/3/19.
//  Copyright © 2019 Lauren Simon. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var content: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let label = UILabel()
        label.text = content
        self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
