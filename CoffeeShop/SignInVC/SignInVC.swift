//
//  SignInVC.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/28/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth
import GoogleSignIn

class SignInVC: UIViewController, GIDSignInUIDelegate {
    
    let signInView = SignInView()
    
    let fbLoginManager = FBSDKLoginManager()
    
    override func loadView() {
        view = signInView
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        hideKeyboard()
        signInView.emailTextField.delegate = self
        signInView.passwordTextField.delegate = self
        signInView.signInButton.tap(signInTapped)
        signInView.signUpButton.tap(signUpTapped)
        signInView.forgotButton.tap(forgotPasswordTapped)
        signInView.facebookButton.tap(fbLoginTapped)
        signInView.googleButton.tap(googleLoginTapped)
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }
    
    private func signUpTapped() {
        let signUpVC = SignUpVC()
        present(signUpVC, animated: true, completion: nil)
    }
    
    private func forgotPasswordTapped() {
        let forgotPasswordVC = ForgotPasswordVC()
        present(forgotPasswordVC, animated: true, completion: nil)
    }
    
    private func googleLoginTapped() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    private func fbLoginTapped() {
        fbLoginManager.logIn(withPublishPermissions: ["publish_actions"], from: self, handler: { (result, error) in
            if (error == nil) {
                print("Login thanh cong")
                self.accessMenuVC()
            } else {
                print(error?.localizedDescription)
            }
        })
    }
    
    private func signInTapped(){
        if let email = signInView.emailTextField.text, let password = signInView.passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    if let user = user {
                        print("login success", user)
                        self.accessMenuVC()
                    }
                }
            })
        }
    }
    
    private func accessMenuVC() {
        print("accessMenuVC")
        
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
        let movementDistance:CGFloat = -100
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
        if textField == signInView.emailTextField {
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

extension SignInVC: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if user != nil {
            print("user: ", user)
            self.accessMenuVC()
        }
    }
}
