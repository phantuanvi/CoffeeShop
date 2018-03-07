//
//  WelcomeVC.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/28/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit
import Firebase

class WelcomeVC: UIViewController {
    
    // MARK: create variables
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
        let signUpVC = SignUpVC()
        present(signUpVC, animated: true, completion: nil)
    }
    
    private func skipTapped() {
        print("skipTapped")
        let signInVC = SignInVC()
        present(signInVC, animated: true, completion: nil)
    }
}
