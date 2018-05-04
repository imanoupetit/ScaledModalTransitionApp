//
//  MasterViewController.swift
//  ImageTransitionApp
//
//  Created by Imanou on 04/05/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let orangeView = UIView()
    let transitionDelegate = TransitionDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Master"
        
        let presentButton = UIBarButtonItem(title: "Show", style: .plain, target: self, action: #selector(presentFullScreenController))
        navigationItem.rightBarButtonItem = presentButton
        
        view.addSubview(orangeView)
        orangeView.backgroundColor = .orange
        orangeView.translatesAutoresizingMaskIntoConstraints = false
        orangeView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        orangeView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        orangeView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        orangeView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150).isActive = true
    }
    
    @objc func presentFullScreenController(_ sender: UIBarButtonItem) {
        let modalViewController = CyanViewController()
        let navigationController = UINavigationController(rootViewController: modalViewController)
        navigationController.transitioningDelegate = transitionDelegate
        navigationController.modalPresentationStyle = .custom
        present(navigationController, animated: true, completion: nil)
    }

}
