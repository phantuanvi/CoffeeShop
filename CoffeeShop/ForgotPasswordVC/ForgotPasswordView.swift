//
//  ForgotPasswordView.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/29/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit
import Stevia

class ForgotPasswordView: UIView {

    // MARK: create views
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
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextFieldViewMode.whileEditing
        textField.textAlignment = .center
        return textField
    }()
    
    let resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reset", for: UIControlState.normal)
        button.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 15)
        button.setTitleColor(WHITE, for: UIControlState.normal)
        button.backgroundColor = MYGREEN
        button.isUserInteractionEnabled = true
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: UIControlState.normal)
        button.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 17)
        button.setTitleColor(MYGREEN, for: UIControlState.normal)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: life cycle
    convenience init() {
        self.init(frame: CGRect.zero)
        
        render()
    }
    
    private func render() {
        sv(
            logoView,
            emailTextField,
            resetButton,
            cancelButton
        )
        
        equalSizes(resetButton, cancelButton)
        logoView.width(100).centerHorizontally()
        
        layout(
            70,
            logoView ~ 100,
            50,
            |-25-emailTextField-25-| ~ 50,
            10,
            |-25-resetButton-25-cancelButton-25-| ~ 50
        )
    }

}
