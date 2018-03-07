//
//  SignUpVC.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/28/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    // MARK: - create variables
    let signUpView = SignUpView()
    
    //MARK: Lifecycle
    override func loadView() {
        view = signUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        signUpView.emailTextField.delegate = self
        signUpView.passwordTextField.delegate = self
        signUpView.confirmPasswordTextField.delegate = self
        
        signUpView.avatarView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectAvatarImageView)))
        signUpView.cancelButton.tap(cancelButtonTapped)
        signUpView.signUpButton.tap(signUpTapped)
        
        self.hideKeyboard()
    }
    
    //MARK: create functions
    @objc func handleSelectAvatarImageView() {
        // Hide the keyboard
        self.view.endEditing(true)
        
        // pick media from photo library
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    private func cancelButtonTapped(){
        print("cancel button tapped")
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    private func forgotPasswordTapped() {
        let forgotPasswordVC = ForgotPasswordVC()
        present(forgotPasswordVC, animated: true, completion: nil)
    }
    
    private func signUpTapped() {
        if (signUpView.emailTextField.text?.isEmpty)! || (signUpView.passwordTextField.text?.isEmpty)! || (signUpView.confirmPasswordTextField.text?.isEmpty)! {
            alertValidate(message: "One of these textFields is empty", handler: nil)
        } else {
            
            guard let email = signUpView.emailTextField.text else { return }
            guard let password = signUpView.passwordTextField.text else { return }
            guard let conPassword = signUpView.confirmPasswordTextField.text else { return }
            
            if password != conPassword {
                alertValidate(message: "Password is not match", handler: nil)
            }
            
            if isValidEmailAddress(email) {
                
                PTVAuthService.sharedInstance.registerUser(email: email, password: password, completion: { (message, success) in
                    if success {
                        self.alertValidate(message: "SignUp is success with \(email)", handler: { (alertAction) in
                            StartApp.shared.start(handler: { (viewController) in
                                self.present(viewController, animated: true, completion: nil)
                            })
                        })
                    } else {
                        self.alertValidate(message: message, handler: nil)
                    }
                })
            } else {
                alertValidate(message: "Invalidate email", handler: nil)
            }
        }
    }
    
    private func isValidEmailAddress(_ email: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = email as NSString
            let results = regex.matches(in: email, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0 {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    private func alertValidate(message: String, handler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "I understand", style: UIAlertActionStyle.cancel, handler: handler)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}


extension SignUpViewController: UITextFieldDelegate {
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
extension SignUpViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
