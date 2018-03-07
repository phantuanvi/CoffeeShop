//
//  WelcomeVC.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/28/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit
import Firebase

protocol WelcomeViewControllerDelegate: class {
    func welcomViewControllerDidSelectSignUp(fromVC: UIViewController)
    func welcomViewControllerDidSelectSkip(fromVC: UIViewController)
}

class WelcomeViewController: UIViewController {
    
    // MARK: create variables
    weak var delegate: WelcomeViewControllerDelegate?
    let welcomeView = WelcomeView()
    
    // MARK: Lifecycle
    override func loadView() {
        view = welcomeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeView.signUpButton.tap(signUpTapped)
        welcomeView.skipButton.tap(skipTapped)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: create functions
    private func signUpTapped(){
        print("signUpTapped")
        delegate?.welcomViewControllerDidSelectSignUp(fromVC: self)
    }
    
    private func skipTapped() {
        print("skipTapped")
        delegate?.welcomViewControllerDidSelectSkip(fromVC: self)
    }
}
