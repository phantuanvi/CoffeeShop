//
//  SignUpVC.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/28/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
    
    let signUpView = SignUpView()
    
    private func signUpTapped() {
        if (signUpView.emailTextField.text?.isEmpty)! || (signUpView.passwordTextField.text?.isEmpty)! || (signUpView.confirmPasswordTextField.text?.isEmpty)! {
            print("One of these textFields is empty")
        } else {
            if let email = signUpView.emailTextField.text, let password = signUpView.passwordTextField.text {
                Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                    if error == nil {
                        print("SignUp success")
                    }
                }
            }
        }
    }
    
    @objc func handleSelectAvatarImageView() {
        
        print("handleSelectAvatarImageView")
        // Hide the keyboard
        self.view.endEditing(true)
        
        // pick media from photo library
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: Lifecycle
    override func loadView() {
        view = signUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        signUpView.avatarView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectAvatarImageView)))
        signUpView.emailTextField.delegate = self
        signUpView.passwordTextField.delegate = self
        signUpView.confirmPasswordTextField.delegate = self
        signUpView.signUpButton.tap(signUpTapped)
        signUpView.cancelButton.tap(cancelButtonTapped)
        
        self.hideKeyboard()
    }
    
    private func cancelButtonTapped(){
        print("cancel button tapped")
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}


extension SignUpVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let scrollPoint = CGPoint(x: 0, y: textField.frame.origin.y-130)
        signUpView.scrollView.setContentOffset(scrollPoint, animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        signUpView.scrollView.setContentOffset(CGPoint.zero, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case signUpView.emailTextField: signUpView.passwordTextField.becomeFirstResponder()
        case signUpView.passwordTextField: signUpView.confirmPasswordTextField.becomeFirstResponder()
        case signUpView.confirmPasswordTextField: self.signUpTapped()
        self.view.endEditing(true)
        default:
            self.view.endEditing(true)
            self.signUpTapped()
        }
        return true
    }
}

// dismiss keyboard when touch outside textField
extension SignUpVC {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension SignUpVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        if let selectedImage = selectedImage {
            signUpView.avatarView.maskCircle(image: selectedImage)
        }
        dismiss(animated: true, completion: nil)
    }
}
