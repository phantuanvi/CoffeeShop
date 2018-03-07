//
//  ForgotPasswordVC.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/29/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordVC: UIViewController {
    
    // MARK: create variables
    let forgotPasswordView = ForgotPasswordView()
    
    // MARK: life cycle
    override func loadView() {
        view = forgotPasswordView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        hideKeyboard()
        forgotPasswordView.emailTextField.delegate = self
        forgotPasswordView.resetButton.tap(resetPasswordTapped)
        forgotPasswordView.cancelButton.tap(cancelButtonTapped)
    }

    // MARK: create functions
    private func resetPasswordTapped() {
        
        if let email = forgotPasswordView.emailTextField.text {
            Auth.auth().sendPasswordReset(withEmail: forgotPasswordView.emailTextField.text!, completion: { (error) in
                if error == nil {
                    print("Password reset email sent.", email)
                    self.presentingViewController?.dismiss(animated: true, completion: nil)
                } else {
                    print(error!.localizedDescription)
                }
            })
        }
    }
    
    private func cancelButtonTapped(){
        print("cancel button tapped")
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

extension ForgotPasswordVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.forgotPasswordView.emailTextField {
            self.view.endEditing(true)
            self.resetPasswordTapped()
        }
        return true
    }
}

// dismiss keyboard when touch outside textField
extension ForgotPasswordVC {
    private func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
