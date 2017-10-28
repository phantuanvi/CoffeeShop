//
//  SignInVC.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/28/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {
    
    let signInView = SignInView()
    
    override func loadView() {
        view = signInView
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        hideKeyboard()
        signInView.userNameTextField.delegate = self
        signInView.passwordTextField.delegate = self
        signInView.signInButton.tap(signInTapped)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    func signInTapped(){
        print("signInTapped")
        
        let menuVC:MenuVC = MenuVC()
        let sideBarVC:SideBarVC = SideBarVC()
        let navigationController:UINavigationController = UINavigationController(rootViewController: menuVC)
        sideBarVC.menuVC = navigationController
        let slideMenuController = SlideMenuController(mainViewController: navigationController, leftMenuViewController: sideBarVC)
        slideMenuController.delegate = menuVC
        present(slideMenuController, animated: true, completion: nil)
    }
}

extension SignInVC: UITextFieldDelegate {
    
    // TextField move up when keyboard is present
    func animateTextField(textField: UITextField, up: Bool) {
        let movementDistance:CGFloat = -130
        let movementDuration: Double = 0.3
        
        var movement:CGFloat = 0
        movement = up ? movementDistance : -movementDistance
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.animateTextField(textField: textField, up: true)
        if !(textField.text?.isEmpty)! {
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.animateTextField(textField: textField, up: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == signInView.userNameTextField {
            signInView.passwordTextField.becomeFirstResponder()
        } else {
            self.view.endEditing(true)
            self.signInTapped()
        }
        return true
    }
}

// dismiss keyboard when touch outside textField
extension SignInVC {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

