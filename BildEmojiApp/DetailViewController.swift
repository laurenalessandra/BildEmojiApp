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
    var label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(label)
        setUpView()
    }
    
    func setUpView() {
        view.backgroundColor = .white
        label.text = content
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
