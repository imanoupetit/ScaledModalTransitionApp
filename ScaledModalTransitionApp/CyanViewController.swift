//
//  CyanViewController.swift
//  ImageTransitionApp
//
//  Created by Imanou on 04/05/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//

import UIKit

class CyanViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Detail"

        view.backgroundColor = .cyan
        
        let dismissButton = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(dismissCurrentViewController))
        navigationItem.rightBarButtonItem = dismissButton
    }
    
    @objc func dismissCurrentViewController(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
