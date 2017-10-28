//
//  SignInView.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/28/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit
import Stevia

class SignInView: UIView {
    
    // MARK: - create sub views and func
    let logoView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "logo")?.withRenderingMode(.alwaysTemplate)
        imgView.tintColor = UIColor.lightGray
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    let userNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "User Name"
        textField.font = UIFont(name: "OpenSans", size: 17)
        textField.borderStyle = UITextBorderStyle.line
        textField.layer.borderColor = UIColor(red: 46/225, green: 204/225, blue: 113/225, alpha: 1).cgColor
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.enablesReturnKeyAutomatically = true
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextFieldViewMode.whileEditing;
        textField.textAlignment = .center
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.font = UIFont(name: "OpenSans", size: 17)
        textField.borderStyle = UITextBorderStyle.line
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.enablesReturnKeyAutomatically = true
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextFieldViewMode.whileEditing;
        textField.textAlignment = .center
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: UIControlState.normal)
        button.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 17)
        button.setTitleColor(WHITE, for: UIControlState.normal)
        button.backgroundColor = MYGREEN
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let signInLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans", size: 16)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.text = "Sign in with Facebook or Google"
        return label
    }()
    
    let facebookButton: UIButton = {
        let facebookButton = UIButton()
        facebookButton.backgroundColor = FACEBOOKCOLOR
        facebookButton.setImage(UIImage(named: "facebookLogo"), for: .normal)
        facebookButton.imageView?.contentMode = .scaleAspectFit
        facebookButton.imageEdgeInsets = UIEdgeInsetsMake(17.0, 17.0, 17.0, 17.0)
        return facebookButton
    }()
    
    let googleButton: UIButton = {
        let googleButton = UIButton()
        googleButton.backgroundColor = GOOGLECOLOR
        googleButton.setImage(UIImage(named: "googleLogo"), for: .normal)
        googleButton.imageView?.contentMode = .scaleAspectFit
        googleButton.imageEdgeInsets = UIEdgeInsetsMake(20.0, 20.0, 20.0, 20.0)
        return googleButton
    }()
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        render()
    }
    
    private func render() {
        sv(
            logoView,
            userNameTextField,
            passwordTextField,
            signInButton,
            signInLabel,
            facebookButton,
            googleButton
        )
        logoView.width(100).centerHorizontally()
        facebookButton.height(50)
        equalSizes(facebookButton, googleButton)
        layout(
            40,
            logoView ~ 100,
            50,
            |-25-userNameTextField-25-| ~ 50,
            10,
            |-25-passwordTextField-25-| ~ 50,
            10,
            |-25-signInButton-25-| ~ 50,
            "",
            |-25-signInLabel-25-| ~ 50,
            10,
            |facebookButton-0-googleButton|,
            0
        )
    }
}
