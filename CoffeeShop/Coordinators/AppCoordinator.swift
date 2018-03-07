//
//  AppCoordinator.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 3/7/18.
//  Copyright © 2018 TuanVi Phan. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    let window: UIWindow
    var viewController: UIViewController?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        if let isFirstTime = PTVAuthService.sharedInstance.isFirstTime {
            if !isFirstTime {
                // When lauch app the first time, run WelcomeVC
                PTVAuthService.sharedInstance.isFirstTime = true
                let welcomeVC = WelcomeViewController()
                welcomeVC.delegate = self
                self.viewController = welcomeVC
            } else {
                StartApp.shared.start { (viewController) in
                    self.viewController = viewController
                }
            }
        }
        window.rootViewController = self.viewController
        window.makeKeyAndVisible()
    }
}

extension AppCoordinator: WelcomeViewControllerDelegate {
    func welcomViewControllerDidSelectSignUp(fromVC: UIViewController) {
        let signUpVC = SignUpViewController()
        fromVC.present(signUpVC, animated: true, completion: nil)
    }
    
    func welcomViewControllerDidSelectSkip(fromVC: UIViewController) {
        let signInVC = SignInViewController()
        fromVC.present(signInVC, animated: true, completion: nil)
    }
}
