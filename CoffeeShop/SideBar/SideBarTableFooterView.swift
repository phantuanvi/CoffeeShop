//
//  SideBarTBLastCell.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/31/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit
import Stevia

class SideBarTableFooterView: UIView {
    
    // MARK: create variables
    var logInButton: UIButton? = {
        let button = UIButton()
        button.setTitle("Log In", for: UIControlState.normal)
        button.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 17)
        button.setTitleColor(WHITE, for: UIControlState.normal)
        button.backgroundColor = MYGREEN
        button.isUserInteractionEnabled = true
        return button
    }()
    
    var registerButton: UIButton? = {
        let button = UIButton()
        button.setTitle("Sign Up", for: UIControlState.normal)
        button.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 17)
        button.setTitleColor(WHITE, for: UIControlState.normal)
        button.backgroundColor = MYGREEN
        button.isUserInteractionEnabled = true
        return button
    }()
    
    var logOutButton: UIButton? = {
        let button = UIButton()
        button.setTitle("Log Out", for: UIControlState.normal)
        button.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 17)
        button.setTitleColor(WHITE, for: UIControlState.normal)
        button.backgroundColor = MYGREEN
        button.isUserInteractionEnabled = true
        return button
    }()

    // MARK: life cycle
    convenience init() {
        self.init(frame: CGRect.zero)
        
        if let isAuth = PTVAuthService.sharedInstance.isAuthenticated {
            if isAuth {
                logInButton = nil
                registerButton = nil
            } else {
                logOutButton = nil
            }
        }
        
        render()
    }
    
    private func render() {
        
        if PTVAuthService.sharedInstance.isAuthenticated! {
            sv(logOutButton!)
            
            logOutButton!.Top == self.Top
            logOutButton!.Left == self.Left
            logOutButton!.Right == self.Right
            logOutButton!.Bottom == self.Bottom
        } else {
            sv(
                logInButton!,
                registerButton!
            )
            
            logInButton!.Left == self.Left
            logInButton!.Top == self.Top
            logInButton!.Right == registerButton!.Left - 2
            logInButton!.Bottom == self.Bottom
            equalWidths(logInButton!, registerButton!)
            
            registerButton!.Top == self.Top
            registerButton!.Right == self.Right
            registerButton!.Bottom == self.Bottom
        }
        
    }
}
