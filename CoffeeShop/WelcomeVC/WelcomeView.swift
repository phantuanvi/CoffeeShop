//
//  WelcomeView.swift
//  CoffeeShop
//
//  Created by TuanVi Phan on 10/28/17.
//  Copyright © 2017 TuanVi Phan. All rights reserved.
//

import UIKit
import Stevia

class WelcomeView: UIView {
    
    //MARK: create sub views and func
    let backgroundView: UIImageView = {
        let imgView = UIImageView()
        imgView.isUserInteractionEnabled = true
        imgView.image = UIImage(named: "backgroundCoffee")
        return imgView
    }()
    
    let logoView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "logo")
        return imgView
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: UIControlState.normal)
        button.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 17)
        button.setTitleColor(WHITE, for: UIControlState.normal)
        button.backgroundColor = MYGREEN
        button.isUserInteractionEnabled = true
        return button
    }()
    
    let skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Already have account - Skip", for: UIControlState.normal)
        button.titleLabel?.font = UIFont(name: "OpenSans", size: 16)
        button.setTitleColor(WHITE, for: UIControlState.normal)
        button.backgroundColor = UIColor.clear
        button.isUserInteractionEnabled = true
        return button
    }()
    
    convenience init() {
        self.init(frame: CGRect.zero)
        render()
    }
    
    func render() {
        //Adding Subview
        sv(
            backgroundView.sv(
                logoView,
                signUpButton,
                skipButton
            )
        )
        //Add constraints
        backgroundView.fillContainer()
        logoView.width(100).centerHorizontally()
        layout(
            100,
            logoView ~ 100,
            "",
            |-25-signUpButton-25-| ~ 50,
            50,
            |skipButton| ~ 50,
            20
        )
    }
}
