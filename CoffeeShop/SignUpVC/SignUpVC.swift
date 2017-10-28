//
//  SignUpVC.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/28/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    let signUpView = SignUpView()
    
    func signUpTapped() {
        if (signUpView.userNameTextField.text?.isEmpty)! || (signUpView.emailTextField.text?.isEmpty)! || (signUpView.passwordTextField.text?.isEmpty)! || (signUpView.confirmPasswordTextField.text?.isEmpty)! {
            print("One of these textFields is empty")
        } else {
            print("Sign Up successfull")
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
        navigationItem.title = "Sign Up"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.gray]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        signUpView.avatarView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectAvatarImageView)))
        signUpView.userNameTextField.delegate = self
        signUpView.emailTextField.delegate = self
        signUpView.passwordTextField.delegate = self
        signUpView.confirmPasswordTextField.delegate = self
        signUpView.signUpButton.tap(signUpTapped)
        
        leftBarButtonItem()
        self.hideKeyboard()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    // Left Bar Button Item
    func leftBarButtonItem() {
        
        let leftButton = UIButton(type: .custom)
        leftButton.setImage(UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), for: UIControlState())
        leftButton.tintColor = UIColor.lightGray
        leftButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        leftButton.addTarget(self, action: #selector(self.leftButtonTapped), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem(customView: leftButton)
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc func leftButtonTapped(){
        dismiss(animated: true, completion: nil)
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
        case signUpView.userNameTextField: signUpView.emailTextField.becomeFirstResponder()
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
