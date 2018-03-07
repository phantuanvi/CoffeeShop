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

enum LogInType {
    case email
    case facebook
    case google
}

class SignInViewController: UIViewController, GIDSignInUIDelegate {
    
    // MARK: create variables
    let signInView = SignInView()
    
    let fbLoginManager = FBSDKLoginManager()
    
    // MARK: life cycle
    override func loadView() {
        view = signInView
    }
    
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
    
    
    //MARK: create functions
    private func signInTapped(){
        if let email = signInView.emailTextField.text, let password = signInView.passwordTextField.text {
            let credential = EmailAuthProvider.credential(withEmail: email, password: password)
            logInOf(type: LogInType.email, credential: credential)
        }
    }
    
    private func signUpTapped() {
        let signUpVC = SignUpViewController()
        present(signUpVC, animated: true, completion: nil)
    }
    
    private func forgotPasswordTapped() {
        let forgotPasswordVC = ForgotPasswordVC()
        present(forgotPasswordVC, animated: true, completion: nil)
    }
    
    private func fbLoginTapped() {
        fbLoginManager.logIn(withPublishPermissions: ["publish_actions"], from: self, handler: { (result, error) in
            
            if let error = error {
                print(error.localizedDescription)
                OperationQueue.main.addOperation {
                    self.presentingViewController?.dismiss(animated: true, completion: nil)
                }
                return
            }
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            self.logInOf(type: .facebook, credential: credential)
        })
    }
    
    private func googleLoginTapped() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    private func logInOf(type: LogInType, credential: AuthCredential) {
        PTVAuthService.sharedInstance.logInWith(credential: credential) { (success) in
            if success {
                StartApp.shared.start(handler: { (viewController) in
                    self.present(viewController, animated: true, completion: nil)
                })
            } else {
                if type == .email {
                    let alertController = UIAlertController(title: "Alert", message: "Incorrect email or password", preferredStyle: UIAlertControllerStyle.alert)
                    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    OperationQueue.main.addOperation {
                        self.presentingViewController?.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
}

extension SignInViewController: UITextFieldDelegate {
    
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
extension SignInViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension SignInViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            OperationQueue.main.addOperation {
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            }
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        logInOf(type: LogInType.google, credential: credential)
    }
}
