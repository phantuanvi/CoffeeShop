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

    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
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
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        render()
    }
    
    private func render() {
        sv(
            emailTextField,
            resetButton,
            cancelButton
        )
        
        equalSizes(resetButton, cancelButton)
        
        layout(
            100,
            |-25-emailTextField-25-| ~ 50,
            10,
            |-25-resetButton-25-cancelButton-25-| ~ 50
        )
    }

}
