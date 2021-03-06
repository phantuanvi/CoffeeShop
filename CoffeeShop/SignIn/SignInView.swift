//
//  SignInView.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/28/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit
import Stevia
import GoogleSignIn

class SignInView: UIView {
    
    // MARK: - create sub variables
    let logoView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "logo")?.withRenderingMode(.alwaysTemplate)
        imgView.tintColor = UIColor.lightGray
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.font = UIFont(name: "OpenSans", size: 17)
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1.0
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.enablesReturnKeyAutomatically = true
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextFieldViewMode.whileEditing;
        textField.textAlignment = .center
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.font = UIFont(name: "OpenSans", size: 17)
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1.0
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
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: UIControlState.normal)
        button.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 17)
        button.setTitleColor(MYGREEN, for: UIControlState.normal)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    let forgotButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot Password?", for: UIControlState.normal)
        button.titleLabel?.font = UIFont(name: "OpenSans", size: 12)
        button.setTitleColor(.gray, for: UIControlState.normal)
        button.backgroundColor = UIColor.clear
        button.isUserInteractionEnabled = true
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
    
    // MARK: - life cycle
    convenience init() {
        self.init(frame: CGRect.zero)
        
        render()
    }
    
    private func render() {
        sv(
            logoView,
            emailTextField,
            passwordTextField,
            signInButton,
            signInLabel,
            signUpButton,
            forgotButton,
            facebookButton,
            googleButton
        )
        logoView.width(100).centerHorizontally()
        facebookButton.height(50)
        equalSizes(facebookButton, googleButton)
        equalSizes(signUpButton, forgotButton)
        signUpButton.height(40)
        layout(
            70,
            logoView ~ 100,
            50,
            |-25-emailTextField-25-| ~ 50,
            10,
            |-25-passwordTextField-25-| ~ 50,
            10,
            |-25-signInButton-25-| ~ 50,
            10,
            |-25-signUpButton-25-forgotButton-25-|,
            "",
            |-25-signInLabel-25-| ~ 50,
            10,
            |facebookButton-0-googleButton|,
            0
        )
    }
}
